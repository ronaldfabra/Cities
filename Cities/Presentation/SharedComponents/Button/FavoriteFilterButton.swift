//
//  FavoriteFilterButton.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


import SwiftUI

struct FavoriteFilterButton: View {
    var isActive: Bool
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            onButtonPressed?()
        }, label: {
            HStack(spacing: CitiesConstants.Dimens.spacing10) {
                ZStack {
                    Image(systemName: CitiesConstants.Icons.favorite)
                        .opacity(isActive ? 1 : .zero)
                        .scaleEffect(isActive ? 1.0 : .zero)
                        .foregroundColor(Color.red)

                    Image(systemName: CitiesConstants.Icons.notFavorite)
                        .opacity(isActive ? .zero : 1)
                        .scaleEffect(isActive ? .zero : 1.0)
                }
                .animation(.bouncy, value: isActive)
                Text(CitiesConstants.Strings.favorites)
                    .font(.system(size: CitiesConstants.Values.value10,
                                  weight: .regular))
            }
        })
        .padding(CitiesConstants.Dimens.spacing8)
        .foregroundStyle(Color.black)
        .background(Capsule().stroke(Color.black, lineWidth: 1))
        .background(isActive ? Color.green.opacity(0.7) : .white)
        .clipShape(Capsule())
    }
}

#Preview {
    @Previewable @State var isActive: Bool = false
    FavoriteFilterButton(isActive: isActive) {
        isActive = !isActive
    }
}
