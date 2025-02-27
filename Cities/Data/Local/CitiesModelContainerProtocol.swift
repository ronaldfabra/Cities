//
//  CitiesModelContainerProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


protocol CitiesModelContainerProtocol {
    func saveCity(city: CityDomainModel) throws
    func removeCity(cityId: Int) throws
    func getAllFavoritesCities() throws -> [CityDomainModel]
}
