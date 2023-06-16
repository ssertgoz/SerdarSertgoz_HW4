//
//  MockSearchInteractor.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import Foundation
@testable import ITunesApp

final class MockSearchInteractor: SearchInteractorProtocol{
    
    var isInvokedPauseMusic = false
    var inkovedPauseMusicCount = 0
    func pauseMusic() {
        isInvokedPauseMusic = true
        inkovedPauseMusicCount += 1
    }
    
    
    var isInvokedFetchSearchResults = false
    var inkovedFetchSearchResultsCount = 0
    
    func fetchSearchResults(text: String) {
        isInvokedFetchSearchResults = true
        inkovedFetchSearchResultsCount += 1
    }
    
    
    
}
