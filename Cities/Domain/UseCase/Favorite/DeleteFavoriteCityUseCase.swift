//
//  DeleteFavoriteCityUseCaseProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol DeleteFavoriteCityUseCaseProtocol {
    func execute(cityId: Int) throws
}

class DeleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(cityId: Int) throws {
        try repository.removeCity(cityId: cityId)
    }
}
