//
//  SearchCitiesView.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


import MapKit
import SwiftUI

struct SearchCitiesView: View {

    typealias Dimens = CitiesConstants.Dimens

    @State private var navigationPath: [CitiesRoute] = []
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var query: String = .empty
    @StateObject private var viewModel: SearchCitiesViewModel
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject private var toastManager: ToastManager
    @State var isDetailOpen: Bool = false

    private var isLandscape: Bool {
        orientation.isLandscape || orientation == .portraitUpsideDown
    }

    init(dependencyContainer: DIContainerProtocol) {
        self._viewModel = StateObject(
            wrappedValue: dependencyContainer.getSearchCitiesViewModel()
        )
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            contentView
                .navigationBarTitle(CitiesConstants.Strings.cities,
                                    displayMode: .inline)
                .navigationBar(CitiesConstants.CitiesColors.green)
                .navigationDestination(for: CitiesRoute.self) { route in
                    switch route {
                    case .map(let city):
                        MapView(currentLocation: $locationManager.currentLocation,
                                coordinate: $viewModel.selectedCityCoordinate)
                        .navigationBarTitle(city.fullName, displayMode: .inline)
                        .navigationBar(CitiesConstants.CitiesColors.green)
                        .accessibilityIdentifier("cityMapView")
                    case .detail(let city):
                        CityDetailView(city: city)
                            .accessibilityIdentifier("cityDetailView")
                            .onAppear {
                                isDetailOpen = true
                            }
                            .onDisappear {
                                isDetailOpen = false
                            }
                    }
                }
                .padding(Dimens.spacing10)
        }
        .accessibilityIdentifier("searchCitiesView")
        .onAppear {
            locationManager.requestLocationPermission()
        }
        .onChange(of: viewModel.error) { _, error in
            switch error {
            case .none:
                toastManager.hideToast()
            default:
                toastManager.showToast(message: error.errorDescription,
                                       type: .error,
                                       fixed: true) {
                    viewModel.tryAgain()
                }
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
            if let city = viewModel.citySelected,
               !isLandscape, !isDetailOpen {
                navigationPath.append(.map(city))
            }
        }
    }
}

// MARK: contentView
extension SearchCitiesView {
    private var contentView: some View {
        VStack {
            if isLandscape {
                landScapeView
            } else {
                searchComponent
            }
        }
    }
}

// MARK: landScapeView
extension SearchCitiesView {
    private var landScapeView: some View {
        HStack(spacing: CitiesConstants.Dimens.spacing20) {
            searchComponent
            MapView(currentLocation: $locationManager.currentLocation,
                    coordinate: $viewModel.selectedCityCoordinate)
            .accessibilityIdentifier("cityMapView")
        }
    }
}

// MARK: searchComponent
extension SearchCitiesView {
    private var searchComponent: some View {
        VStack {
            if viewModel.isLoading {
                skeletonView
            } else {
                VStack(alignment: .leading, spacing: Dimens.spacing10) {
                    SearchBar(text: $query)
                        .onChange(of: query) { _, newValue in
                            viewModel.updateQuery(query: newValue)
                        }
                    Divider()
                    FavoriteFilterButton(isActive: viewModel.showFavorites) {
                        viewModel.showFavorites.toggle()
                    }
                    .accessibilityIdentifier("searchCitiesViewShowOnlyFavoritesButton")
                    Divider()
                    if viewModel.filteredCities.isEmpty {
                        emptyView
                    } else {
                        listView
                    }
                }
            }
        }
    }

    private var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredCities, id: \.id) { city in
                    VStack(spacing: CitiesConstants.Dimens.spacing8) {
                        CityRow(
                            city: city,
                            isFavorite: viewModel.isFavorite(cityId: city.id),
                            isLandscape: isLandscape,
                            isSelected: viewModel.cityIsSelected(city: city),
                            onItemTap: {
                                Task {
                                    viewModel.setCitySelected(city: city)
                                    if !isLandscape {
                                        navigationPath.append(.map(city))
                                    }
                                }
                            },
                            onInfoButtonTap: {
                                navigationPath.append(.detail(city))
                            },
                            onFavoriteButtonTap: {
                                viewModel.updateFavorite(city: city)
                            }
                        )
                        .accessibilityIdentifier("cityRow_\(city.id)")
                        if city != viewModel.filteredCities.last {
                            Divider()
                        }
                    }
                }
            }
        }
        .accessibilityIdentifier("searchCitiesListView")
    }
}

// MARK: skeletonView
extension SearchCitiesView {
    var skeletonView: some View {
        ScrollView {
            VStack(spacing: Dimens.spacing20) {
                SkeletonView().frame(height: Dimens.spacing40)
                Divider()
                SkeletonView().frame(height: Dimens.spacing50)
                SkeletonView().frame(height: Dimens.spacing50)
                SkeletonView().frame(height: Dimens.spacing50)
                SkeletonView().frame(height: Dimens.spacing50)
                SkeletonView().frame(height: Dimens.spacing50)
                SkeletonView().frame(height: Dimens.spacing50)
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: emptyView
extension SearchCitiesView {
    private var emptyView: some View {
        VStack {
            Spacer()
            Text(CitiesConstants.Strings.EmptyState.Search.title)
                .font(.system(size: CitiesConstants.Values.value20, weight: .light))
                .accessibilityIdentifier(CitiesConstants.Strings.EmptyState.Search.title)
            Spacer()
        }
        .padding(Dimens.spacing50)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    SearchCitiesView(dependencyContainer: MockDIContainer())
        .environmentObject(ToastManager())
}
