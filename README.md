# Cities

[![Build](https://github.com/ronaldfabra/Cities/actions/workflows/build.yml/badge.svg)](https://github.com/ronaldfabra/Cities/actions/workflows/build.yml)

[![codecov](https://codecov.io/gh/ronaldfabra/Cities/branch/master/graph/badge.svg?token=3G8XLZ41UJ)](https://codecov.io/gh/ronaldfabra/Cities)

Cities is an application for Ualá to list cities and can see the location in a map.

## Prerequisites

Before running the project, make sure to set up the project correctly.

1. Clone the repository.
2. After cloning the repository, open **Cities.xcodeproj** file at the root of the project.
3. After open **Cities.xcodeproj** file you are ready to build and run the project.

   
## Architecture

The project follows the Clean Architecture approach, using also the DI pattern ensuring high cohesion and low coupling through layer separation:

- Data Layer: Groups components associated with different data sources to get the data like network and local database using Swift Data, such as mappers, response models (Dto), endpoints and repositories.
- DIContainer: Contains a class to get the app viewmodels and handle the dependency injection.
- Domain Layer: Contains business specifications with different use cases, and domain models.
- Extensions: Contains some class extensions to handle the data.
- Presentation Layer: Contains the desing patterns, functionality modules and shared components used in all the application.
- Utils: Contain some util funcitonalities to process and handle the data.

## Design Pattern

The project follows the MVVM and Builder ensuring separation of responsibilities, better maintenance and testing of business logic:

- Builder Layer: Contains the logic that allows to create complex objects step by step, which is useful when you need to instantiate objects that have many properties as ViewModels.

## Dependency Injection

The project uses Dependency Injection (DI) to facilitate layer separation, following the principle of dependency inversion. This prevents the domain layer from having direct references to the data layer, making the code easier to test and maintain. The DI is handle using the Builder desing pattern, which is to efficiently to handle the memory leak when have too many class instances.

## Unit test
Unit tests have been implemented for viewModels, use cases, repositories and database container as these components contain most of the project's logic.

## UI test
UI tests have been implemented for the views to ensure to have the expected components.

## API
- **URL base**: `https://gist.githubusercontent.com`
- **Available Services**:
    - Cities: `GET /{userName}/{userToken}/raw/cities.json`
 
## Continuous Integration (CI) with GitHub Actions
A CI pipeline has been integrated using GitHub Actions to automatically validate the project. This pipeline performs the following tasks:

- **Runs Unit Tests**: Verifies that all tests pass correctly.
- **Checks Code Coverage with Codecov**: Generates a test coverage report and ensures that defined thresholds are met. this coverage can be find in `https://app.codecov.io/gh/ronaldfabra/Cities`

## Pipeline local with pipeline.sh

In addition to the GitHub Actions pipeline, you can run the same CI process locally using a **run_tests.sh** script. This script will perform all the necessary validations to ensure code quality before pushing changes to the repository. 

## Instructions to Run the Local Pipeline:

1. Make sure you have the `run_tests.sh` file in the root of the project.
2. Open a terminal in the project directory and run the following command:

   ```properties 
    ./run_tests.sh

## Other Information
- this app was developed in SwiftUI with Swift languages.
- the requests was developed using async and await that are the new structured concurrency changes that arrived in Swift 5.5 during WWDC 2021.
- the app support portrait and landscape orientation.
- the app use a local database to handle the favorites cities this with Swift Data.
- the app has unit tests and ui tests to ensure the correct behavior this with Swift Tests and XCTests.
- the app support the errors handler.
- there is no any third library, all the application was made with own code.
