//
//  MockDetailInteracotr.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import Foundation
@testable import ITunesApp

final class MockDetailInteractor: DetailInteractorProtocol{
    
    var isInvokedPlayMusic = false
    var inkovedPlayMusicCount = 0
    func playMusic(url: String) {
        isInvokedPlayMusic = true
        inkovedPlayMusicCount = 1
    }
    
    var isInvokedPauseMusic = false
    var inkovedPauseMusic = 0
    func pauseMusic() {
        isInvokedPauseMusic = true
        inkovedPauseMusic = 1
    }
    
    var isInvokedSaveToFavorites = false
    var inkovedSaveToFavoritesCount = 0
    func saveToFavorites(favorite: ITunesApp.SongEntity) {
        isInvokedSaveToFavorites = true
        inkovedSaveToFavoritesCount = 1
    }
    
    var isInvokedIsFavorite = false
    var inkovedIsFavoriteCount = 0
    func isFavorite(trackId: Int) {
        isInvokedIsFavorite = true
        inkovedIsFavoriteCount = 1
    }
    
    var isInvokedCheckForSaveOrDelete = false
    var inkovedCheckForSaveOrDeleteCount = 0
    func checkForSaveOrDelete(trackId: Int) {
        isInvokedCheckForSaveOrDelete = true
        inkovedCheckForSaveOrDeleteCount = 1
    }
    
    var isInvokedDeleteFromFavorites = false
    var inkovedDeleteFromFavoritesCount = 0
    func deleteFromFavorites(trackId: Int) {
        isInvokedDeleteFromFavorites = true
        inkovedDeleteFromFavoritesCount = 1
    }
    
    
}
