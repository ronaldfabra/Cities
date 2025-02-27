//
//  NetworkProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


protocol NetworkProtocol {
    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T
}