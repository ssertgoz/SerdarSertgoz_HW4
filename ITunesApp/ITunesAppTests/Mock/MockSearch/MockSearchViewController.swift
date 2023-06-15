//
//  MockSearchViewController.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import Foundation
@testable import ITunesApp

final class MockSearchViewController: SearchViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var invokedShowLoadingCount = 0
    
    func showLoadingView() {
        isInvokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
    
    var isInvokedSetupCollectionView = false
    var invokedSetupCollectionView = 0
    
    func setupCollectionView() {
        isInvokedSetupCollectionView = true
        invokedSetupCollectionView += 1
    }
    
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedError = false
    var invokedErrorCount = 0
    
    func showError(_ message: String) {
        isInvokedError = true
        invokedErrorCount += 1
    }
    
    
    var isInvokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title:String, Void)?
    
    func setTitle(_ title: String) {
        isInvokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
    }
    
    var isInvokedViewDidLoaded = false
    var invokedViewDidLoaded = 0
    var invokedViewDidLoadedParameters: (backButtonTtile: String, favoriteIamgeName: String, Void)?
    
    func viewDidLoaded(backButtonTtile: String, favoritesImageName: String) {
        isInvokedViewDidLoaded = false
        invokedViewDidLoaded = 0
        invokedViewDidLoadedParameters = (backButtonTtile, favoritesImageName, ())
    }
}
