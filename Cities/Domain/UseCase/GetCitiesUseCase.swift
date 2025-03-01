//
//  GetCitiesUseCase.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol GetCitiesUseCaseProtocol {
    func execute() async throws -> [CityDomainModel]
}

class GetCitiesUseCase: GetCitiesUseCaseProtocol {
    private let repository: CityRepositoryProtocol

    init(repository: CityRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CityDomainModel] {
        try await repository.getCities()
    }
}
