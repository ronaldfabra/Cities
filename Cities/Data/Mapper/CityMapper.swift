//
//  CityMapper.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


class CityMapper: MapperProtocol {
    typealias T = CityDto
    typealias U = CityDomainModel

    func adapt(apiResponse: CityDto) -> CityDomainModel {
        let coord = apiResponse.coord.toDomain()
        return CityDomainModel(
            id: apiResponse.id,
            country: apiResponse.country,
            name: apiResponse.name,
            latitude: coord.latitude,
            longitude: coord.longitude
        )
    }
}