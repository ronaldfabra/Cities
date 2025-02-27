//
//  FavoriteRepositoryTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class FavoriteRepositoryTests: XCTestCase {

    @MainActor
    func testFetAllFavoritesCities() throws {
        // Given
        let database = CitiesModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            let response = try repository.getAllFavoritesCities()
            // Then
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
        // Then
    }

    @MainActor
    func testSaveCity() {
        // Given
        let city = CityDomainModel(
            id: 1,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let database = CitiesModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            try repository.saveFavoriteCity(city: city)
            let response = try repository.getAllFavoritesCities()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == 1)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @MainActor
    func testRemoveCity() {
        // Given
        let city = CityDomainModel(
            id: 1,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let database = CitiesModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            try repository.saveFavoriteCity(city: city)
            var response = try repository.getAllFavoritesCities()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == 1)

            try repository.removeCity(cityId: city.id)
            response = try repository.getAllFavoritesCities()
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
