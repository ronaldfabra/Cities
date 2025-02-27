//
//  MapView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI
import MapKit

struct MapView: View {
    var defaultCoordinate: CLLocationCoordinate2D
    @Binding var coordinate: CLLocationCoordinate2D

    @State private var cameraPosition: MapCameraPosition

    init(defaultCoordinate: CLLocationCoordinate2D,
         coordinate: Binding<CLLocationCoordinate2D>) {
        self.defaultCoordinate = defaultCoordinate
        self._coordinate = coordinate
        cameraPosition = .region(
            MKCoordinateRegion(
                center: defaultCoordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.1,
                    longitudeDelta: 0.1
                )
            )
        )
    }

    var body: some View {
        Map(position: $cameraPosition)
            .mapControls {
                MapUserLocationButton()
            }
            .onChange(of: defaultCoordinate) { _, newCoordinate in
                updateCameraPosition(coordinate: newCoordinate)
            }
            .onChange(of: coordinate) { _, newCoordinate in
                updateCameraPosition(coordinate: newCoordinate)
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
    @Previewable @State var defaultCoordinate: CLLocationCoordinate2D = .init(
        latitude: .zero,
        longitude: .zero
    )

    @Previewable @State var coordinate: CLLocationCoordinate2D = .init(
        latitude: .zero,
        longitude: .zero
    )

    VStack {
        MapView(defaultCoordinate: defaultCoordinate,
                coordinate: $coordinate)
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
