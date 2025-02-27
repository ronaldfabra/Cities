//
//  CityCoordMapper.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


class CityCoordMapper: MapperProtocol {
    typealias T = CityCoordDto
    typealias U = CityCoordDomainModel

    func adapt(apiResponse: CityCoordDto) -> CityCoordDomainModel {
        CityCoordDomainModel(
            latitude: apiResponse.latitude,
            longitude: apiResponse.longitude
        )
    }
}
