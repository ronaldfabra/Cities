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
    var isLandScape: Bool
    var onItemTap: (() -> Void)?
    var onFavoriteButtonTap: (() -> Void)?

    init(
        city: CityDomainModel,
        isFavorite: Bool,
        isLandScape: Bool,
        onItemTap: (() -> Void)? = nil,
        onFavoriteButtonTap: (() -> Void)? = nil
    ) {
        self.city = city
        self.isFavorite = isFavorite
        self.isLandScape = isLandScape
        self.onItemTap = onItemTap
        self.onFavoriteButtonTap = onFavoriteButtonTap
    }

    var body: some View {
        if isLandScape {
            landScapeRow(city)
        } else {
            portraitRow(city)
        }
    }

    private func landScapeRow(_ city: CityDomainModel) -> some View {
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func portraitRow(_ city: CityDomainModel) -> some View {
        NavigationLink(value: city) {
            HStack {
                cityInformation
                Spacer()
                FavoriteButton(
                    isFavorite: isFavorite,
                    onButtonPressed: onFavoriteButtonTap
                )
            }
            .padding(CitiesConstants.Dimens.spacing5)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var cityInformation: some View {
        VStack(alignment: .leading) {
            Text(String(format: "%@, %@",
                        city.name,
                        city.country))
            .font(.system(size: CitiesConstants.Values.value20,
                          weight: .regular))
            .foregroundStyle(Color.black)
            VStack(alignment: .leading) {
                Text(CitiesConstants.Strings.coordinatesTitle)
                Text(String(format: CitiesConstants.Strings.coordinatesValue,
                            city.latitude,
                            city.longitude))
            }
            .font(.system(size: CitiesConstants.Values.value14,
                          weight: .light))
            .foregroundStyle(Color.gray)
        }
    }
}

#Preview {
    CityRow(
        city: .init(id: 1, country: "CO", name: "Santa Marta", latitude: 11.2303485, longitude: -74.2008869),
        isFavorite: false,
        isLandScape: true
    )
    .border(Color.red, width: 1.0)
    .padding()
}
