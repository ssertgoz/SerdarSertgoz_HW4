//
//  MockDetailPresenterTest.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import XCTest
@testable import ITunesApp


final class MockDetailPresenterTest: XCTestCase {

    var presenter: DetailPresenter!
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        presenter = .init(view: view, interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func test_viewDidLoad(){
        XCTAssertFalse(view.isInvokedUpdateTrackImage)
        XCTAssertEqual(view.invokedUpdateTrackImageCount, 0)
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertFalse(view.isInvokedUpdateTrackNameLabel)
        XCTAssertEqual(view.invokedUpdateTrackNameLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateCollectionPriceLabel)
        XCTAssertEqual(view.invokedUpdateCollectionPriceLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateTrackPriceLabel)
        XCTAssertEqual(view.invokedUpdateTrackPriceLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateGenreNameLabel)
        XCTAssertEqual(view.invokedUpdateGenreNameLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateArtistNameLabel)
        XCTAssertEqual(view.invokedUpdateArtistNameLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateCollectionNameLabel)
        XCTAssertEqual(view.invokedUpdateCollectionNameLabelCount, 0)
        XCTAssertFalse(view.isInvokedUpdateProgressBarView)
        XCTAssertEqual(view.invokedUpdateProgressBarViewCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedUpdateTrackImage)
        XCTAssertEqual(view.invokedUpdateTrackImageCount, 1)
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "")
        XCTAssertTrue(view.isInvokedUpdateTrackNameLabel)
        XCTAssertEqual(view.invokedUpdateTrackNameLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateCollectionPriceLabel)
        XCTAssertEqual(view.invokedUpdateCollectionPriceLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateTrackPriceLabel)
        XCTAssertEqual(view.invokedUpdateTrackPriceLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateGenreNameLabel)
        XCTAssertEqual(view.invokedUpdateGenreNameLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateArtistNameLabel)
        XCTAssertEqual(view.invokedUpdateArtistNameLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateCollectionNameLabel)
        XCTAssertEqual(view.invokedUpdateCollectionNameLabelCount, 1)
        XCTAssertTrue(view.isInvokedUpdateProgressBarView)
        XCTAssertEqual(view.invokedUpdateProgressBarViewCount, 1)
        
    }

}



