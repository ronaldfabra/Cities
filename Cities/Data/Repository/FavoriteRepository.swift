//
//  FavoriteRepository.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


class FavoriteRepository: FavoriteRepositoryProtocol {
    private let database: CitiesModelContainerProtocol

    init(database: CitiesModelContainerProtocol) {
        self.database = database
    }

    func getAllFavoritesCities() throws -> [CityDomainModel] {
        try database.getAllFavoritesCities()
    }

    func saveFavoriteCity(city: CityDomainModel) throws {
        try database.saveCity(city: city)
    }

    func removeCity(cityId: Int) throws {
        try database.removeCity(cityId: cityId)
    }
}
