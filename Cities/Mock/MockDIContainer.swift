//
//  MockDIContainer.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 28/02/25.
//


class MockDIContainer: DIContainerProtocol {
    let withError: Bool

    init(withError: Bool = false) {
        self.withError = withError
    }

    func getSearchCitiesViewModel() -> SearchCitiesViewModel {
        let cityRepository = MockCityRepository()
        cityRepository.mockCityListResponse = withError ? [] : cityRepository.mockCityListResponse
        let favoriteRepository = FavoriteRepository(database: CitiesModelContainer(storeInMemoryOnly: true))
        let getCitiesUseCase = GetCitiesUseCase(repository: cityRepository)
        let getFavoritesCitiesUseCase = GetFavoritesCitiesUseCase(repository: favoriteRepository)
        let addFavoriteCityUseCase = AddFavoriteCityUseCase(repository: favoriteRepository)
        let deleteFavoriteCityUseCase = DeleteFavoriteCityUseCase(repository: favoriteRepository)
        let viewModel = SearchCitiesViewModel(
            getCitiesUseCase: getCitiesUseCase,
            getFavoritesCitiesUseCase: getFavoritesCitiesUseCase,
            addFavoriteCityUseCase: addFavoriteCityUseCase,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCase
        )
        return viewModel
    }
}
