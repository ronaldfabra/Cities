//
//  CityDetailViewUITests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 1/03/25.
//

@testable import Cities
import XCTest

final class CityDetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testViewIsPresentInPortraitOrientation() {
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

        let cityRow = listView.buttons["cityRow_1"]
        let cityRowInfoButton = listView.buttons["cityRowInformationButton_1"]

        XCTAssertTrue(cityRow.exists)
        XCTAssertTrue(cityRowInfoButton.exists)
        cityRowInfoButton.tap()

        let cityDetailView = app.otherElements["cityDetailView"]

        expectation(for: existsPredicate, evaluatedWith: cityDetailView, handler: nil)

        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(cityDetailView.exists)
    }

    @MainActor
    func testViewIsPresentInLandscapeOrientation() {
        XCUIDevice.shared.orientation = .landscapeRight
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

        let cityRow = listView.buttons["cityRow_1"]
        let cityRowInfoButton = listView.buttons["cityRowInformationButton_1"]

        XCTAssertTrue(cityRow.exists)
        XCTAssertTrue(cityRowInfoButton.exists)
        cityRowInfoButton.tap()

        let cityDetailView = app.otherElements["cityDetailView"]

        expectation(for: existsPredicate, evaluatedWith: cityDetailView, handler: nil)

        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(cityDetailView.exists)
    }
}
