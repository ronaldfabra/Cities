//
//  SearchCitiesViewModel.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import Combine
import Foundation
import SwiftUI

class SearchCitiesViewModel: ObservableObject {
    private var cities: [CityDomainModel] = []
    @Published var filteredCities: [CityDomainModel] = []
    @Published var favorites: [CityDomainModel] = []
    @Published var isLoading: Bool = false
    @Published var showFavorites: Bool = false {
        didSet {
            Task {
                await showOnlyFavorites(show: showFavorites)
            }
        }
    }
    @Published var error: NetworkErrorType = .none
    private var cancellables = Set<AnyCancellable>()
    private var querySubject = CurrentValueSubject<String, Never>(.empty)

    private let getCitiesUseCase: GetCitiesUseCaseProtocol
    private let getFavoritesCitiesUseCase: GetFavoritesCitiesUseCaseProtocol
    private let addFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol
    private let deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseProtocol

    init(getCitiesUseCase: GetCitiesUseCaseProtocol,
         getFavoritesCitiesUseCase: GetFavoritesCitiesUseCaseProtocol,
         addFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol,
         deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseProtocol) {
        self.getCitiesUseCase = getCitiesUseCase
        self.getFavoritesCitiesUseCase = getFavoritesCitiesUseCase
        self.addFavoriteCityUseCase = addFavoriteCityUseCase
        self.deleteFavoriteCityUseCase = deleteFavoriteCityUseCase
        querySubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                Task {
                    await self.searchCities(query: query)
                }
            }
            .store(in: &cancellables)
        getCities()
        getFavorites()
    }

    private func getCities() {
        if cities.isEmpty {
            Task {
                do {
                    await showLoading(true)
                    let response = try await getCitiesUseCase.execute()
                    await self.processCitiesResponse(response)
                } catch {
                    await self.processError(error)
                }
            }
        }
    }

    private func getFavorites() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.error = .none
            do {
                self.favorites = try self.getFavoritesCitiesUseCase.execute()
                searchCities(query: querySubject.value)
            } catch {
                self.error = .generalError
            }
        }
    }

    @MainActor
    private func showLoading(_ show: Bool) {
        self.isLoading = show
    }

    @MainActor
    private func processCitiesResponse(_ response: [CityDomainModel]) {
        cities = response.sorted { $0.name < $1.name }
        filteredCities = cities
        showLoading(false)
    }

    @MainActor
    private func searchCities(query: String) {
        if query.isEmpty {
            filteredCities = showFavorites ? favorites : cities
        } else {
            filteredCities = (showFavorites ? favorites : cities).filter { city in
                city.name.lowercased().hasPrefix(query.lowercased())
            }
        }
    }

    @MainActor
    private func processError(_ error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
        showLoading(false)
    }

    @MainActor
    private func resetData() {
        self.error = .none
        filteredCities = showFavorites ? favorites : cities
    }

    @MainActor
    private func showOnlyFavorites(show: Bool) {
        Task {
            filteredCities = show ? favorites : cities
            searchCities(query: querySubject.value)
        }
    }

    private func addToFavorite(city: CityDomainModel) async {
        do {
            try addFavoriteCityUseCase.execute(city: city)
        } catch {
            self.error = .generalError
        }
    }

    private func removeFromFavorite(cityId: Int) async {
        do {
            try deleteFavoriteCityUseCase.execute(cityId: cityId)
        } catch {
            self.error = .generalError
        }
    }
}

// MARK: view functions
extension SearchCitiesViewModel {
    func updateQuery(query: String) {
        querySubject.send(query)
    }

    func tryAgain() {
        Task {
            await resetData()
            getCities()
        }
    }
}

// MARK: Favorites functions
extension SearchCitiesViewModel {
    func updateFavorite(city: CityDomainModel) {
        Task {
            if isFavorite(cityId: city.id) {
                await removeFromFavorite(cityId: city.id)
            } else {
                await addToFavorite(city: city)
            }
            getFavorites()
        }
    }

    func isFavorite(cityId: Int) -> Bool {
        favorites.contains(where: { $0.id == cityId })
    }
}
