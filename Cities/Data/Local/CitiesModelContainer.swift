//
//  CitiesModelContainer.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import Foundation
import SwiftData

actor CitiesModelContainer: NSObject {

    static let shared: CitiesModelContainer = CitiesModelContainer()

    let modelContainer: ModelContainer

    init(storeInMemoryOnly: Bool = false) {
        self.modelContainer = CitiesModelContainer.createContainer(storeInMemoryOnly: storeInMemoryOnly)
    }

    static func createContainer(storeInMemoryOnly: Bool = false) -> ModelContainer {
        let schema = Schema([CityLocalDomainModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: storeInMemoryOnly)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("unable to create the contaienr: \(error)")
        }
    }
}

// MARK: CitiesModelContainerProtocol
extension CitiesModelContainer: @preconcurrency CitiesModelContainerProtocol {
    @MainActor
    func saveCity(city: CityDomainModel) throws {
        do {
            let cityToSave = CityLocalDomainModel(
                id: city.id,
                country: city.country,
                name: city.name,
                latitude: city.latitude,
                longitude: city.longitude
            )
            modelContainer.mainContext.insert(cityToSave)
            try modelContainer.mainContext.save()
        } catch {
            throw error
        }
    }

    @MainActor
    func removeCity(cityId: Int) throws {
        do {
            guard let city = try getCityById(cityId) else { return }
            modelContainer.mainContext.delete(city)
            try modelContainer.mainContext.save()
        } catch {
            throw error
        }
    }

    @MainActor
    private func getCityById(_ id: Int) throws -> CityLocalDomainModel? {
        do {
            let CityPredicate = #Predicate<CityLocalDomainModel> {
                $0.id == id
            }
            let descriptor = FetchDescriptor<CityLocalDomainModel>(predicate: CityPredicate)
            let cities = try modelContainer.mainContext.fetch(descriptor)
            return cities.first
        } catch {
            throw error
        }
    }

    @MainActor
    func getAllFavoritesCities() throws -> [CityDomainModel] {
        do {
            let descriptor = FetchDescriptor<CityLocalDomainModel>()
            let cities = try modelContainer.mainContext.fetch(descriptor)
            return cities
                .map {
                    CityDomainModel(
                        id: $0.id,
                        country: $0.country,
                        name: $0.name,
                        latitude: $0.latitude,
                        longitude: $0.longitude
                    )
                }
        } catch {
            throw error
        }
    }
}
