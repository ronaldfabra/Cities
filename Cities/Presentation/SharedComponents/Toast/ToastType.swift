//
//  ToastType.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


import SwiftUI

enum ToastType {
    case success
    case error
    case warning

    func getColor() -> Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .yellow
        }
    }
}
