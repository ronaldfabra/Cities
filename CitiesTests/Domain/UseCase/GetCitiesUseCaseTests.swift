//
//  GetCitiesUseCaseTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class GetCitiesUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let CityRepository = CityRepositoryMock()
        let getCitiesUseCase = GetCitiesUseCase(repository: CityRepository)
        do {
            // When
            let response = try await getCitiesUseCase.execute()
            // Then
            #expect(response.count == CityRepository.mockCityListResponse.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithEmptyResponse() async throws {
        // Given
        let CityRepository = CityRepositoryMock()
        CityRepository.mockCityListResponse = []
        let getCitiesUseCase = GetCitiesUseCase(repository: CityRepository)
        do {
            // When
            let _ = try await getCitiesUseCase.execute()
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
