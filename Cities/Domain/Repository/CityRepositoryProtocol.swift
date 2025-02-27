//
//  CityRepositoryProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol CityRepositoryProtocol {
    func getCities() async throws -> [CityDomainModel]
}
