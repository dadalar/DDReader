//
//  DDReaderUITests.swift
//  DDReaderUITests
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import XCTest

class DDReaderUITests: XCTestCase {

    func testViewingCachedData() {
        let app = XCUIApplication()
        app.launchEnvironment = ["UI_TESTING": "1"]
        app.launch()
        
        // Mock data has cached data. Check if we are seeing all the labels
        XCTAssert(app.staticTexts["Title 1"].exists)
        XCTAssert(app.staticTexts["Body 1"].exists)
        XCTAssert(app.staticTexts["Title 2"].exists)
        XCTAssert(app.staticTexts["Body 2"].exists)
        XCTAssert(app.staticTexts["Title 3"].exists)
        XCTAssert(app.staticTexts["Body 3"].exists)
        XCTAssert(app.staticTexts["You're viewing cached data"].exists)
        
        app.cells.firstMatch.tap() // Go into detail screen
        
        // Check detail screen texts
        let titleLabel = app.staticTexts["titleLabel"]
        XCTAssert(titleLabel.exists)
        XCTAssertEqual(titleLabel.label, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        let bodyLabel = app.staticTexts["bodyLabel"]
        XCTAssert(bodyLabel.exists)
        XCTAssertEqual(bodyLabel.label, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        let authorLabel = app.staticTexts["authorNameLabel"]
        XCTAssert(authorLabel.exists)
        XCTAssertEqual(authorLabel.label, "Deniz Adalar\n@dadalar")
        
        let commentCountLabel = app.staticTexts["commentCountLabel"]
        XCTAssert(commentCountLabel.exists)
        XCTAssertEqual(commentCountLabel.label, "Comments: 0")
    }

    func testNonCachedError() {
        let app = XCUIApplication()
        app.launchEnvironment = ["UI_TESTING": "1",
                                 "UI_TESTING_ERROR": "1"]
        app.launch()

        XCTAssertEqual(app.cells.count, 0) // No data, zero cell
        let alert = app.alerts["Mock Error Title"]
        XCTAssert(alert.exists)
        XCTAssert(alert.staticTexts["Mock Error Message"].exists)
    }
    
}
