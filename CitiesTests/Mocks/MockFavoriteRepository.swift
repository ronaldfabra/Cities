//
//  MockFavoriteRepository.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 28/02/25.
//


@testable import Cities

class MockFavoriteRepository: FavoriteRepositoryProtocol {

    var favoriteList: [CityDomainModel] = []

    func getAllFavoritesCities() throws -> [CityDomainModel] {
        favoriteList
    }

    func saveFavoriteCity(city: CityDomainModel) throws {
        if city.id == .zero {
            throw NetworkErrorType.invalidData
        } else {
            favoriteList.append(city)
        }
    }

    func removeCity(cityId: Int) throws {
        if let index = favoriteList.firstIndex(where: { $0.id == cityId }) {
            favoriteList.remove(at: index)
        }
    }
}
