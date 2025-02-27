//
//  FavoriteRepositoryProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol FavoriteRepositoryProtocol {
    func getAllFavoritesCities() throws -> [CityDomainModel]
    func saveFavoriteCity(city: CityDomainModel) throws
    func removeCity(cityId: Int) throws
}
