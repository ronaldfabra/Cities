//
//  MapViewUITests.swift
//  Cities
//
//  Created by Ronal Fabra Jimenez on 28/02/25.
//

@testable import Cities
import XCTest

final class MapViewUITests: XCTestCase {

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

        XCTAssertTrue(cityRow.exists)
        cityRow.tap()

        let cityMapView = app.otherElements["cityMapView"]

        expectation(for: existsPredicate, evaluatedWith: cityMapView, handler: nil)

        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(cityMapView.exists)
    }

    @MainActor
    func testViewIsPresentInLandScapeOrientation() {
        XCUIDevice.shared.orientation = .landscapeRight
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST")
        app.launch()

        let searchCitiesView = app.otherElements["searchCitiesView"]
        let listView = app.scrollViews["searchCitiesListView"]
        let cityMapView = app.otherElements["cityMapView"]

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: searchCitiesView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: listView, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: cityMapView, handler: nil)

        waitForExpectations(timeout: 60, handler: nil)

        XCTAssertTrue(searchCitiesView.exists)
        XCTAssertTrue(listView.exists)
        XCTAssertTrue(cityMapView.exists)

        let cityRow = listView.buttons["cityRow_1"]

        XCTAssertTrue(cityRow.exists)
        cityRow.tap()
    }
}
