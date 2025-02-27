//
//  SearchCitiesViewModelBuilder.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


struct SearchCitiesViewModelBuilder {
    static func make() -> SearchCitiesViewModel {
        let cityRepository = CityRepository(network: Network.shared)
        let favoriteRepository = FavoriteRepository(database: CitiesModelContainer.shared)
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
