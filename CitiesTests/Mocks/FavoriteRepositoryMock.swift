//
//  FavoriteRepositoryMock.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities
import Foundation

class FavoriteRepositoryMock: FavoriteRepositoryProtocol {

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
