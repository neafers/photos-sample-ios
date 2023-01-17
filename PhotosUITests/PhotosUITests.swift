//
//  PhotosUITests.swift
//  PhotosUITests
//
//  Created by jeff on 11/7/20.
//

import XCTest

class PhotosUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClick3Images() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 6).tap()

        let photosButton = app.navigationBars["Photos.ImageView"].buttons["Photos"]
        photosButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 13).swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 7).tap()
        photosButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 16).swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 15).tap()
        photosButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
