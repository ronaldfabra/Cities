//
//  GetFavoritesCitiesUseCase.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol GetFavoritesCitiesUseCaseProtocol {
    func execute() throws -> [CityDomainModel]
}

class GetFavoritesCitiesUseCase: GetFavoritesCitiesUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol

    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }

    func execute() throws -> [CityDomainModel] {
        try repository.getAllFavoritesCities()
    }
}
