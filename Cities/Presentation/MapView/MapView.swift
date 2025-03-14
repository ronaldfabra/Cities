//
//  MapView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import SwiftUI
import MapKit

struct MapView: View {
    @Binding var currentLocation: CLLocationCoordinate2D?
    @Binding var coordinate: CLLocationCoordinate2D?
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @Environment(\.presentationMode) var presentationMode
    @State private var cameraPosition: MapCameraPosition
    private var applyRotationLogic: Bool

    private var isLandscape: Bool {
        orientation.isLandscape || orientation == .portraitUpsideDown
    }

    init(currentLocation: Binding<CLLocationCoordinate2D?> = .constant(nil),
         coordinate: Binding<CLLocationCoordinate2D?>,
         applyRotationLogic: Bool = true) {
        self._currentLocation = currentLocation
        self._coordinate = coordinate
        self.applyRotationLogic = applyRotationLogic
        let center: CLLocationCoordinate2D = coordinate.wrappedValue ?? currentLocation.wrappedValue ?? .init()
        cameraPosition = .region(
            MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.1,
                    longitudeDelta: 0.1
                )
            )
        )
    }

    var body: some View {
        Map(position: $cameraPosition) {
            if let coordinate {
                Marker(String.empty, coordinate: coordinate)
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onChange(of: coordinate) { _, newCoordinate in
            updateCameraPosition(coordinate: newCoordinate)
        }
        .onChange(of: currentLocation) { _, newCoordinate in
            updateCameraPosition(coordinate: newCoordinate)
        }
        .onRotate { newOrientation in
            orientation = newOrientation
            if isLandscape, applyRotationLogic {
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
    @Previewable @State var currentLocation: CLLocationCoordinate2D?
    @Previewable @State var coordinate: CLLocationCoordinate2D?

    VStack {
        MapView(currentLocation: $currentLocation,
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
