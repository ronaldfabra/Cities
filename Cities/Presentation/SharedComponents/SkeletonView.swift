//
//  SkeletonView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

struct SkeletonView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(CitiesConstants.Dimens.spacing8)
    }
}

#Preview {
    SkeletonView()
        .frame(height: 40)
        .padding()
}
