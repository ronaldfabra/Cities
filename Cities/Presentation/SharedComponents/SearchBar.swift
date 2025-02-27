//
//  SearchBar.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField(CitiesConstants.Strings.searchCities, text: $text)
            .padding(CitiesConstants.Dimens.spacing10)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(CitiesConstants.Dimens.spacing10)
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: {
                            text = .empty
                        }) {
                            Image(systemName: CitiesConstants.Icons.clear)
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, CitiesConstants.Dimens.spacing10)
                    }
                }
            )
            .foregroundColor(.primary)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .accessibilityIdentifier("searchCitiesTextfield")
    }
}

#Preview {
    @Previewable @State var text: String = .init()
    SearchBar(text: $text)
        .padding()
}
