//
//  CityCoordDto.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


struct CityCoordDto: Hashable, DTOProtocol {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }

    func toDomain() -> CityCoordDomainModel {
        CityCoordMapper().adapt(apiResponse: self)
    }
}
