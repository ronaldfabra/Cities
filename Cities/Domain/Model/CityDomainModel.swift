//
//  CityDomainModel.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


struct CityDomainModel: Identifiable, Hashable, Equatable {
    let id: Int
    let country: String
    let name: String
    let latitude: Double
    let longitude: Double

    static func == (lhs: CityDomainModel, rhs: CityDomainModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.country == rhs.country &&
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
