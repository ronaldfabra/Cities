//
//  CitiesApp.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//

import SwiftUI

@main
struct CitiesApp: App {
    @StateObject private var toastManager = ToastManager()

    var body: some Scene {
        WindowGroup {
            ZStack {
                SearchCitiesView(dependencyContainer: DIContainer.shared)
                ToastView()
            }
            .environmentObject(toastManager)
        }
    }
}
