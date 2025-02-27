//
//  CityLocalDomainModel.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


import SwiftData

@Model
final class CityLocalDomainModel {
    var id: Int
    var country: String
    var name: String
    var latitude: Double
    var longitude: Double

    init(
        id: Int,
        country: String,
        name: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.country = country
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
