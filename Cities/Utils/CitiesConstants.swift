//
//  CitiesConstants.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//


struct CitiesConstants {
    struct CitiesURL {
        static let baseURL = "https://gist.githubusercontent.com"
    }

    struct Strings {
        struct NetworkError {
            static let invalidURL = "The url seems to be incorrect, try again later."
            static let serverError = "Internal server error, try again later."
            static let invalidData = "Error in the data obtained, try again later."
            static let internetConnection = "The internet connection appears to be offline."
            static let general = "System error, try again later."
        }

        static let favorites = "favorites"
        static let searchCities = "Search Cities"
        static let tryAgain = "Try Again"
        static let coordinatesTitle = "coordinates:"
        static let coordinatesValue = "latitude: %f, longitude: %f"

        struct EmptyState {
            struct Search {
                static let title = "There are no results for your search, try searching with a new text and you will find the location on the map of your city."
            }
        }
    }

    struct Icons {
        static let favorite = "heart.fill"
        static let notFavorite = "heart"
        static let list = "list.bullet"
        static let grid = "square.grid.2x2"
        static let downArrow = "chevron.down"
        static let clear = "xmark.circle.fill"
    }

    struct Dimens {
        static let spacing5 = 5.0
        static let spacing8 = 8.0
        static let spacing10 = 10.0
        static let spacing20 = 20.0
        static let spacing40 = 40.0
        static let spacing50 = 50.0
    }

    struct Values {
        static let value10 = 10.0
        static let value14 = 14.0
        static let value20 = 20.0
    }

    struct LaunchArgument {
        static let responseError = "RESPONSE_ERROR"
        static let uiTests = "UI_TEST"
    }
}
