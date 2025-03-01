//
//  View+Extension.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }

    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }

    func navigationBar(_ background: Color = .yellow) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}
