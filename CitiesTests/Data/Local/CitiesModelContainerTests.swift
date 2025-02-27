//
//  CitiesModelContainerTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class CitiesModelContainerTests: XCTestCase {

    @MainActor
    func testFetAllFavoritesCities() throws {
        // Given
        let dataStorage = CitiesModelContainer(storeInMemoryOnly: true)
        do {
            // When
            let response = try dataStorage.getAllFavoritesCities()
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
        let dataStorage = CitiesModelContainer(storeInMemoryOnly: true)
        do {
            // When
            try dataStorage.saveCity(city: city)
            let response = try dataStorage.getAllFavoritesCities()
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
        let dataStorage = CitiesModelContainer(storeInMemoryOnly: true)
        do {
            // When
            try dataStorage.saveCity(city: city)
            var response = try dataStorage.getAllFavoritesCities()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == 1)

            try dataStorage.removeCity(cityId: city.id)
            response = try dataStorage.getAllFavoritesCities()
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
