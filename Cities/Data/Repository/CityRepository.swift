//
//  CityRepository.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


class CityRepository: CityRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getCities() async throws -> [CityDomainModel] {
        let response = try await network.request(
            endPoint: CityEndpoint.get,
            type: [CityDto].self
        )
        return response.map { $0.toDomain() }
    }
}
