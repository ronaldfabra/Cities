//
//  DTOProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol DTOProtocolDecodable: Decodable & DomainModelable {}
protocol DTOProtocol: Codable & DomainModelable {}

protocol DomainModelable {
    associatedtype DomainModel

    func toDomain() throws -> DomainModel
}
