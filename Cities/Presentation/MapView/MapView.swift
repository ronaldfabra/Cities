//
//  MapView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI
import MapKit

struct MapView: View {
    @Binding var coordinate: CLLocationCoordinate2D
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @Environment(\.presentationMode) var presentationMode
    @State private var cameraPosition: MapCameraPosition

    private var isLandscape: Bool {
        orientation.isLandscape || orientation == .portraitUpsideDown
    }

    init(coordinate: Binding<CLLocationCoordinate2D>) {
        self._coordinate = coordinate
        cameraPosition = .region(
            MKCoordinateRegion(
                center: coordinate.wrappedValue,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.1,
                    longitudeDelta: 0.1
                )
            )
        )
    }

    var body: some View {
        Map(position: $cameraPosition) {
            Marker(String.empty, coordinate: coordinate)
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onChange(of: coordinate) { _, newCoordinate in
            updateCameraPosition(coordinate: newCoordinate)
        }
        .onRotate { newOrientation in
            orientation = newOrientation
            if isLandscape {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func updateCameraPosition(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1,
                                       longitudeDelta: 0.1)
            )
        )
    }
}

#Preview {
    @Previewable @State var coordinate: CLLocationCoordinate2D = .init(
        latitude: .zero,
        longitude: .zero
    )

    VStack {
        MapView(coordinate: $coordinate)
        Button {
            coordinate = .init(
                latitude: 11.2303485,
                longitude: -74.2008869
            )
        } label: {
            Text("click me")
        }
    }
}
