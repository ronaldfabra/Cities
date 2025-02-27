//
//  ToastManager.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

class ToastManager: ObservableObject {
    @Published var message: String = .empty
    @Published var type: ToastType = .error
    @Published var isVisible: Bool = false
    @Published var onTryAgainAction: (() -> Void)? = nil

    func showToast(message: String, type: ToastType, fixed: Bool = false, onTryAgainAction: (() -> Void)? = nil) {
        self.message = message
        self.type = type
        self.isVisible = true
        self.onTryAgainAction = onTryAgainAction

        if !fixed {
            hideToast(duration: 3)
        }
    }

    func hideToast(duration: CGFloat = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isVisible = false
            }
            self.onTryAgainAction = nil
        }
    }
}
