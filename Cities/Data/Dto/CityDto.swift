//
//  CityDto.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


struct CityDto: Identifiable, Hashable, DTOProtocol {
    let id: Int
    let country: String
    let name: String
    let coord: CityCoordDto

    enum CodingKeys: String, CodingKey {
        case country, name, coord
        case id = "_id"
    }

    func toDomain() -> CityDomainModel {
        CityMapper().adapt(apiResponse: self)
    }

    static func == (lhs: CityDto, rhs: CityDto) -> Bool {
        lhs.id == rhs.id &&
        lhs.country == rhs.country &&
        lhs.name == rhs.name
    }
}
