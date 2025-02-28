//
//  SearchCitiesViewUITests.swift
//  CitiesUITests
//
//  Created by Ronal Fabra Jimenez on 26/02/25.
//

@testable import Cities
import XCTest

final class SearchCitiesViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testViewIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
    }

    @MainActor
    func testSearchTextfieldIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let searchTextField = app.textFields["searchCitiesTextfield"]
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
        XCTAssertTrue(searchTextField.exists)
    }

    @MainActor
    func testListViewIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let listView = app.scrollViews["searchCitiesListView"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: listView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
        XCTAssertTrue(listView.exists)
    }

    @MainActor
    func testEmptyViewIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let searchTextField = app.textFields["searchCitiesTextfield"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Bogota")

        let emptyViewTitle = app.staticTexts["There are no results for your search, try searching with a new text and you will find the location on the map of your city."]

        expectation(for: existsPredicate, evaluatedWith: emptyViewTitle, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(emptyViewTitle.exists)
    }

    @MainActor
    func testShowOnlyFavoritesButtonIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)

        let showOnlyFavoritesButton = app.buttons["searchCitiesViewShowOnlyFavoritesButton"]

        expectation(for: existsPredicate, evaluatedWith: showOnlyFavoritesButton, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(showOnlyFavoritesButton.exists)
        showOnlyFavoritesButton.tap()
    }

    @MainActor
    func testToasViewErrorIsPresent() {
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launchArguments.append("RESPONSE_ERROR")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let searchTextField = app.textFields["searchCitiesTextfield"]
        let toastView = app.staticTexts["toastView"]
        
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: searchTextField, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: toastView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
        XCTAssertTrue(searchTextField.exists)
        XCTAssertTrue(toastView.exists)
    }
}
