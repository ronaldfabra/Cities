//
//  NetworkMock.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


@testable import Cities

class NetworkMock<T: Decodable>: NetworkProtocol {

    var mockResponse: T? = nil

    func request<U: Decodable>(endPoint: EndPointProtocol, type _: U.Type) async throws -> U {
        if let mockResponse =  mockResponse as? U {
            return mockResponse
        } else {
            throw NetworkErrorType.invalidData
        }
    }
}
