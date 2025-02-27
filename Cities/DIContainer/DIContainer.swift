//
//  DIContainer.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 27/02/25.
//


class DIContainer: DIContainerProtocol {
    static var shared: DIContainerProtocol = DIContainer()

    func getSearchCitiesViewModel() -> SearchCitiesViewModel {
        SearchCitiesViewModelBuilder.make()
    }
}
