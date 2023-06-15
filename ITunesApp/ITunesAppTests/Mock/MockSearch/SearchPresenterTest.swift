//
//  SearchPresenterTest.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import XCTest
@testable import ITunesApp
@testable import ITunesAPI

final class SearchPresenterTest: XCTestCase {
    
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!
    
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router)
        
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func test_viewDidLoad_InvokesRequiredViewMoethods() {
        
        XCTAssertFalse(view.isInvokedSetupCollectionView)
        XCTAssertEqual(view.invokedSetupCollectionView, 0)
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertFalse(interactor.isInvokedFetchSearchResults)
        XCTAssertEqual(interactor.inkovedFetchSearchResultsCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupCollectionView)
        XCTAssertEqual(view.invokedSetupCollectionView, 1)
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "iTunes Search")
        
    }
    
    func test_fetchNewsOutput() {

        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems, 0)
        XCTAssertFalse(view.isInvokedReloadData)

        presenter.handleSearchResult(.success(.response))

        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItems, 25)
        XCTAssertTrue(view.isInvokedReloadData)
    }

}

extension SongsResultResponse {

    static var response: SongsResultResponse {
        let bundle = Bundle(for: SearchPresenterTest.self)
        let path = bundle.path(forResource: "SearchResult", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongsResultResponse.self, from: data)
        
        return response
    }
}
