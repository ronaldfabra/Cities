//
//  AddFavoriteCityUseCaseProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol AddFavoriteCityUseCaseProtocol {
    func execute(city: CityDomainModel) throws
}

class AddFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol

    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }

    func execute(city: CityDomainModel) throws {
        try repository.saveFavoriteCity(city: city)
    }
}
