//
//  MockCityRepository.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 28/02/25.
//


class MockCityRepository: CityRepositoryProtocol {

    var mockCityListResponse: [CityDomainModel] = [CityDomainModel(
        id: 1,
        country: "CO",
        name: "Santa Marta",
        latitude: 11.2303485,
        longitude: -74.2008869
    )]

    func getCities() async throws -> [CityDomainModel] {
        if mockCityListResponse.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockCityListResponse
        }
    }
}
