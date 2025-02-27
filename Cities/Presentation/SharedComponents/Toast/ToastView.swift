//
//  ToastView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI

struct ToastView: View {
    @EnvironmentObject var toastManager: ToastManager
    private let toastAnimationDuration: Double = 0.3

    var body: some View {
        VStack {
            Spacer()
            if toastManager.isVisible {
                VStack {
                    HStack {
                        Text(toastManager.message)
                            .font(.system(size: CitiesConstants.Values.value14,
                                          weight: .regular))
                        Spacer()
                        if let onTryAgainAction = toastManager.onTryAgainAction {
                            Button {
                                onTryAgainAction()
                            } label: {
                                Text(CitiesConstants.Strings.tryAgain)
                                    .font(.system(size: CitiesConstants.Values.value14,
                                                  weight: .medium))
                            }
                        }
                    }
                    .padding()
                    .background(toastManager.type.getColor())
                    .foregroundColor(.white)
                    .cornerRadius(CitiesConstants.Dimens.spacing8)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: toastAnimationDuration), value: toastManager.isVisible)
                    .padding(.bottom, CitiesConstants.Dimens.spacing40)
                    .edgesIgnoringSafeArea(.bottom)
                }
                .padding()
            }
        }
    }
}

#Preview {
    @Previewable @State var toastManager = ToastManager()
    ToastView()
        .onAppear {
            toastManager.showToast(message: "error text",
                                   type: .error,
                                   fixed: true)
        }
    .environmentObject(toastManager)
}
