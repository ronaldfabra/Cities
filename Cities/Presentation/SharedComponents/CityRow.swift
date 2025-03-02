//
//  CityRow.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

struct CityRow: View {

    var city: CityDomainModel
    var isFavorite: Bool
    var isLandscape: Bool
    var isSelected: Bool
    var onItemTap: (() -> Void)?
    var onFavoriteButtonTap: (() -> Void)?

    private var applyLandscapeStyle: Bool {
        isSelected && isLandscape
    }

    init(
        city: CityDomainModel,
        isFavorite: Bool,
        isLandscape: Bool,
        isSelected: Bool,
        onItemTap: (() -> Void)? = nil,
        onFavoriteButtonTap: (() -> Void)? = nil
    ) {
        self.city = city
        self.isFavorite = isFavorite
        self.isLandscape = isLandscape
        self.isSelected = isSelected
        self.onItemTap = onItemTap
        self.onFavoriteButtonTap = onFavoriteButtonTap
    }

    var body: some View {
        Button {
            onItemTap?()
        } label: {
            HStack {
                cityInformation
                Spacer()
                FavoriteButton(
                    isFavorite: isFavorite,
                    onButtonPressed: onFavoriteButtonTap
                )
            }
            .padding(CitiesConstants.Dimens.spacing5)
            .frame(alignment: .leading)
            .contentShape(.rect)
        }
        .contentShape(.rect)
        .buttonStyle(PlainButtonStyle())
        .if(applyLandscapeStyle, content: { view in
            view.background(CitiesConstants.CitiesColors.green)
        })
    }

    private var cityInformation: some View {
        VStack(alignment: .leading) {
            Text(city.fullName)
            .font(.system(size: CitiesConstants.Values.value14,
                          weight: .medium))
            .foregroundStyle(Color.black)
            VStack(alignment: .leading) {
                Text(CitiesConstants.Strings.coordinatesTitle)
                    .font(.system(size: CitiesConstants.Values.value14,
                                  weight: .medium))
                    .foregroundStyle(Color.black)
                VStack(alignment: .leading) {
                    Text(String(format: CitiesConstants.Strings.latitude,
                                city.latitude))
                    Text(String(format: CitiesConstants.Strings.longitude,
                                city.longitude))
                }
                .font(.system(size: CitiesConstants.Values.value10,
                              weight: .regular))
                .foregroundStyle(applyLandscapeStyle ? Color.white : Color.gray)
            }
        }
    }
}

#Preview {
    CityRow(
        city: .init(id: 1, country: "CO", name: "Santa Marta", latitude: 11.2303485, longitude: -74.2008869),
        isFavorite: true,
        isLandscape: true,
        isSelected: true
    )
    .padding()
}
