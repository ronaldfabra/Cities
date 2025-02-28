//
//  DeleteFavoriteCityUseCaseTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class DeleteFavoriteCityUseCaseTests {
    @Test func removeCity() async throws {
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
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteCityUseCase.execute(city: city)
            // Then
            #expect(favoriteRepository.favoriteList.count == 1)
            #expect(favoriteRepository.favoriteList.last?.id == city.id)

            try deleteFavoriteCityUseCase.execute(cityId: city.id)
            #expect(favoriteRepository.favoriteList.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func removeCitytWithInvalidCityId() async throws {
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
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteCityUseCase.execute(city: city)
            // Then
            #expect(favoriteRepository.favoriteList.count == 1)
            #expect(favoriteRepository.favoriteList.last?.id == city.id)

            try deleteFavoriteCityUseCase.execute(cityId: .zero)
            #expect(!favoriteRepository.favoriteList.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
