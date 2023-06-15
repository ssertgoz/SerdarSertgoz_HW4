//
//  ITunesAppUITests.swift
//  ITunesAppUITests
//
//  Created by serdar on 7.06.2023.
//

import XCTest

final class ITunesAppUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testExample() throws {
        app.launch()
        sleep(3)
        XCTAssertTrue(app.isSearchBarDisplayed)
        XCTAssertTrue(app.isCollectionviewDisplayed)
        XCTAssertTrue(app.isEmptyviewDisplayed)
        XCTAssertTrue(app.isBackgroundViewDisplayed)
                
        app.searchBar!.tap()
        app.searchBar?.typeText("tarkan")
        sleep(2)
        app.collectionview.children(matching: .cell).element(boundBy: 0).staticTexts["Tarkan"].tap()
        app/*@START_MENU_TOKEN@*/.images["play.fill"]/*[[".images[\"play\"]",".images[\"play.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(10)
        app.images["Stop"].tap()
        sleep(1)
        app.navigationBars["iTunes Search"].buttons["Back"].tap()
        app.collectionview.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.swipeUp()
        sleep(1)
        app.collectionview.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.swipeDown()
        
        sleep(3)
    }
}

extension XCUIApplication {
    
    var searchBar: XCUIElement! {
        searchFields["Search"]
    }
    var collectionview: XCUIElement! {
        collectionViews["collectionview"]
    }
    var emptyview: XCUIElement! {
        otherElements["emptyview"]
    }
    var backgroundview: XCUIElement! {
        otherElements["backgroundview"]
    }
    
    var isSearchBarDisplayed: Bool {
        searchBar.exists
    }
    
    var isCollectionviewDisplayed: Bool {
        collectionview.exists
    }
    
    var isEmptyviewDisplayed: Bool {
        emptyview.exists
    }
    
    var isBackgroundViewDisplayed: Bool {
        backgroundview.exists
    }
}
