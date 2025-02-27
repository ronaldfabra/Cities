//
//  CityEndpoint.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


enum CityEndpoint {
    case get
}

extension CityEndpoint: EndPointProtocol {
    var baseUrl: String {
        CitiesConstants.CitiesURL.baseURL
    }

    var userName: String {
        "hernan-uala"
    }

    var userToken: String {
        CitiesUtils.getUserToken()
    }

    var relativeURL: String {
        switch self {
        case .get:
            return "raw/cities.json"
        }
    }

    var method: String {
        return URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
        case .get:
            return "\(baseUrl)/\(userName)/\(userToken)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        return [:]
    }
}
