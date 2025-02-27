//
//  EndPointProtocol.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


public protocol EndPointProtocol {
    var method: String { get }
    var urlString: String { get }
    var parameters: [String: Any] { get }
}

public enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
