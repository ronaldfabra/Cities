//
//  CityRepositoryTests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Testing
import XCTest

final class CityRepositoryTests {
    @Test func getCities() async throws {
        // Given
        let network = NetworkMock<[CityDto]>()
        let mockResponse: [CityDto] = [.init(id: 1,
                                             country: "CO",
                                             name: "Santa Marta",
                                             coord: .init(latitude: 11.2303485,
                                                          longitude: -74.2008869))]
        network.mockResponse = mockResponse
        let repository: CityRepositoryProtocol = CityRepository(network: network)
        do {
            // When
            let response = try await repository.getCities()
            // Then
            #expect(response.count == mockResponse.count)
            #expect(response.first?.id == mockResponse.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func searchCityWithInvalidToken() async throws {
        // Given
        let network = NetworkMock<[CityDto]>()
        let repository: CityRepositoryProtocol = CityRepository(network: network)
        do {
            // When
            let _ = try await repository.getCities()
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
