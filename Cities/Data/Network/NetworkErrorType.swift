//
//  NetworkErrorType.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import Foundation

enum NetworkErrorType: LocalizedError, Equatable {
    case invalidURL
    case invalidParams
    case invalidData
    case internetConnection
    case generalError
    case unkown(Error)
    case none
    
    static func == (lhs: NetworkErrorType, rhs: NetworkErrorType) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
    
    var errorDescription: String {
        switch self {
        case .invalidURL: CitiesConstants.Strings.NetworkError.invalidURL
        case .invalidParams: CitiesConstants.Strings.NetworkError.serverError
        case .invalidData: CitiesConstants.Strings.NetworkError.invalidData
        case .internetConnection: CitiesConstants.Strings.NetworkError.internetConnection
        case .generalError: CitiesConstants.Strings.NetworkError.general
        case .unkown(let error): error.localizedDescription
        case .none: .empty
        }
    }
    
    static func error(from error: ApiErrorDto) -> NetworkErrorType {
        switch error.code ?? .zero {
        case ResponseStatusType.notFound.rawValue: NetworkErrorType.invalidParams
        default: NetworkErrorType.unkown(error)
        }
    }
}
