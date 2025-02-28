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
                SearchCitiesView(dependencyContainer: getDIContainer())
                ToastView()
                    .accessibilityIdentifier("toastView")
            }
            .environmentObject(toastManager)
        }
    }

    private func getDIContainer() -> DIContainerProtocol {
        if ProcessInfo.processInfo.arguments.contains(CitiesConstants.LaunchArgument.uiTests) {
            let responseError = ProcessInfo.processInfo.arguments.contains(CitiesConstants.LaunchArgument.responseError)
            return MockDIContainer(withError: responseError)
        } else {
            return DIContainer()
        }
    }
}
