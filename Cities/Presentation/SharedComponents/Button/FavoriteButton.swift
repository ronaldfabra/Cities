//
//  FavoriteButton.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

struct FavoriteButton: View {

    var isFavorite: Bool
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: CitiesConstants.Dimens.spacing10) {
            ZStack {
                Image(systemName: CitiesConstants.Icons.favorite)
                    .opacity(isFavorite ? 1 : .zero)
                    .scaleEffect(isFavorite ? 1.0 : .zero)
                    .foregroundColor(Color.red)

                Image(systemName: CitiesConstants.Icons.notFavorite)
                    .opacity(isFavorite ? .zero : 1)
                    .scaleEffect(isFavorite ? .zero : 1.0)
            }
        }
        .padding(CitiesConstants.Dimens.spacing10)
        .animation(.bouncy, value: isFavorite)
        .onTapGesture {
            onButtonPressed?()
        }
        .containerShape(.circle)
    }
}

#Preview {
    @Previewable @State var isFavorite: Bool = false
    FavoriteButton(isFavorite: isFavorite) {
        isFavorite = !isFavorite
    }
}
