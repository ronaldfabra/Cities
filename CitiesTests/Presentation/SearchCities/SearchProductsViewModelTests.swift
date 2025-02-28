//
//  SearchCitiesViewModelTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class SearchCitiesViewModelTests: XCTestCase {

    func testUpdateQuery() {
        // Given
        let query = "Santa Marta"
        let cityRepository = MockCityRepository()
        let favoriteRepository = MockFavoriteRepository()
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for Cities is updated")
        let cancellable = viewModel.$filteredCities.sink { cities in
            if !cities.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateQuery(query: query)
        wait(for: [expectation], timeout: 5.0)
        // Then
        #expect(viewModel.filteredCities.count == cityRepository.mockCityListResponse.count)
        #expect(viewModel.filteredCities.first?.id == cityRepository.mockCityListResponse.first?.id)

        cancellable.cancel()
    }

    func testUpdateQueryWithDifferentValue() {
        // Given
        let query = "test"
        let cityRepository = MockCityRepository()
        let favoriteRepository = MockFavoriteRepository()
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        // When
        viewModel.updateQuery(query: query)
        // Then
        #expect(viewModel.filteredCities.isEmpty)
    }

    func testTryAgain() {
        // Given
        let cityRepository = MockCityRepository()
        cityRepository.mockCityListResponse = []
        let favoriteRepository = MockFavoriteRepository()
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for Cities is updated")
        let cancellable = viewModel.$filteredCities.sink { cities in
            if !cities.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        cityRepository.mockCityListResponse = [.init(id: 1,
                                                     country: "CO",
                                                     name: "Santa Marta",
                                                     latitude: 11.2303485,
                                                     longitude: -74.2008869)]
        viewModel.tryAgain()
        wait(for: [expectation], timeout: 5.0)
        // Then
        #expect(viewModel.filteredCities.count == cityRepository.mockCityListResponse.count)
        #expect(viewModel.filteredCities.first == cityRepository.mockCityListResponse.first)
        cancellable.cancel()
    }

    func testAddFavorite() {
        // Given
        let city = CityDomainModel(
            id: 1,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let cityRepository = MockCityRepository()
        let favoriteRepository = MockFavoriteRepository()
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for productDescription is updated")
        let cancellable = viewModel.$favorites.sink { favorites in
            if !favorites.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateFavorite(city: city)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.favorites.count == 1)

        cancellable.cancel()
    }

    func testDeleteFavorite() {
        // Given
        let city = CityDomainModel(
            id: 1,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let cityRepository = MockCityRepository()
        let favoriteRepository = MockFavoriteRepository()
        favoriteRepository.favoriteList = [city]
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for productDescription is updated")
        let cancellable = viewModel.$favorites.sink { favorites in
            if favorites.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateFavorite(city: city)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.favorites.isEmpty)

        cancellable.cancel()
    }
}
