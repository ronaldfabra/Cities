//
//  AddFavoriteCityUseCaseTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class AddFavoriteCityUseCaseTests {
    @Test func saveFavoriteCity() async throws {
        // Given
        let city = CityDomainModel(
            id: 1,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let favoriteRepository = MockFavoriteRepository()
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteCityUseCase.execute(city: city)
            // Then
            #expect(favoriteRepository.favoriteList.count == 1)
            #expect(favoriteRepository.favoriteList.last?.id == city.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func saveFavoriteCityWithCityIdZero() async throws {
        // Given
        let city = CityDomainModel(
            id: 0,
            country: "CO",
            name: "Santa Marta",
            latitude: 11.2303485,
            longitude: -74.2008869
        )
        let favoriteRepository = MockFavoriteRepository()
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteCityUseCase.execute(city: city)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
