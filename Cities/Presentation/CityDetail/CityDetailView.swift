//
//  CityDetailView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 1/03/25.
//


import SwiftUI

struct CityDetailView: View {
    var city: CityDomainModel

    var body: some View {
        VStack(alignment: .leading, spacing: CitiesConstants.Dimens.spacing20) {
            VStack(alignment: .leading, spacing: CitiesConstants.Dimens.spacing5) {
                Text(city.fullName)
                    .font(.system(size: CitiesConstants.Values.value20,
                                  weight: .medium))
                    .foregroundStyle(Color.black)
                Text(CitiesConstants.Strings.coordinatesTitle)
                    .font(.system(size: CitiesConstants.Values.value14,
                                  weight: .medium))
                    .foregroundStyle(Color.black)
                HStack {
                    Text(String(format: CitiesConstants.Strings.latitude,
                                city.latitude))
                    Text(String(format: CitiesConstants.Strings.longitude,
                                city.longitude))
                }
                .font(.system(size: CitiesConstants.Values.value14,
                              weight: .regular))
                .foregroundStyle(Color.gray)
            }
            MapView(
                coordinate: .constant(.init(
                    latitude: city.latitude,
                    longitude: city.longitude
                )),
                applyRotationLogic: false)
            .accessibilityIdentifier("cityMapView")
        }
        .padding()
        .navigationBarTitle(city.fullName, displayMode: .inline)
        .navigationBar(CitiesConstants.CitiesColors.green)
    }
}

#Preview {
    CityDetailView(
        city: .init(id: 1, country: "CO", name: "Santa Marta", latitude: 11.2303485, longitude: -74.2008869)
    )
    .padding()
}
