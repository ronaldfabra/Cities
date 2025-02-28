//
//  DIContainer.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


class DIContainer: DIContainerProtocol {
    func getSearchCitiesViewModel() -> SearchCitiesViewModel {
        SearchCitiesViewModelBuilder.make(network: Network.shared,
                                          database: CitiesModelContainer())
    }
}
