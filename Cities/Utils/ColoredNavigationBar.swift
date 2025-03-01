//
//  ColoredNavigationBar.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 1/03/25.
//


import SwiftUI

struct ColoredNavigationBar: ViewModifier {
    var background: Color

    func body(content: Content) -> some View {
        content
            .toolbarBackground(background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
