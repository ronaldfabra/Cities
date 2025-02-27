//
//  CitiesUtils.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//

import Foundation

class CitiesUtils {
    static func getUserToken() -> String {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "USER_TOKEN") as? String
        return apiKey ?? .empty
    }
}
