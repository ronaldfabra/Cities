//
//  GetFavoritesCitiesUseCaseTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class GetFavoritesCitiesUseCaseTests {
    @Test func getAllFavoritesCities() async throws {
        // Given
        let favoriteRepository = FavoriteRepositoryMock()
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        do {
            // When
            let response = try getFavoritesCitiesUseCase.execute()
            // Then
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
