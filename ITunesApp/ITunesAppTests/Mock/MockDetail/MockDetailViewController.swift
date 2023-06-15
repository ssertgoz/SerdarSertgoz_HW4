//
//  MockDetailViewController.swift
//  ITunesAppTests
//
//  Created by serdar on 15.06.2023.
//

import Foundation
@testable import ITunesApp
@testable import ITunesAPI

final class MockDetailViewController: DetailViewControllerProtocol{
    
    var isInvokedGetSource = false
    var invokedGetSourceCount = 0
    func getSource() -> ITunesApp.SongEntity? {
        isInvokedGetSource = true
        invokedGetSourceCount += 1
        return SingleSong.song
    }
    
    var isInvokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters : (title:String, Void)?
    func setTitle(_ title: String) {
        isInvokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
    }
    
    var isInvokedUpdateTrackNameLabel = false
    var invokedUpdateTrackNameLabelCount = 0
    func updateTrackNameLabel(text: String) {
        isInvokedUpdateTrackNameLabel = true
        invokedUpdateTrackNameLabelCount += 1
    }
    
    var isInvokedUpdateCollectionNameLabel = false
    var invokedUpdateCollectionNameLabelCount = 0
    func updateCollectionNameLabel(text: String) {
        isInvokedUpdateCollectionNameLabel = true
        invokedUpdateCollectionNameLabelCount += 1
    }
    
    var isInvokedSetPlayImage = false
    var invokedSetPlayImageCount = 0
    func setPlayImage(_ isPlaying: Bool, _ stopImageName: String, _ playImageName: String) {
        isInvokedSetPlayImage = true
        invokedSetPlayImageCount += 1
    }
    
    var isInvokedStartPlayAnimation = false
    var invokedStartPlayAnimationCount = 0
    func startPlayAnimation(elapsedTime: String, totalTime: String, progress: Double) {
        isInvokedStartPlayAnimation = true
        invokedStartPlayAnimationCount += 1
    }

    var isInvokedStopPlayAnimation = false
    var invokedStopPlayAnimationCount = 0
    func stopPlayAnimation(_ stopImageName: String, _ playImageName: String) {
        isInvokedStopPlayAnimation = true
        invokedStopPlayAnimationCount += 1
    }
    
    var isInvokedUpdateTrackImage = false
    var invokedUpdateTrackImageCount = 0
    func updateTrackImage(url: String) {
        isInvokedUpdateTrackImage = true
        invokedUpdateTrackImageCount += 1
    }
    
    var isInvokedUpdateCollectionPriceLabel = false
    var invokedUpdateCollectionPriceLabelCount = 0
    func updateCollectionPriceLabel(text: String) {
        isInvokedUpdateCollectionPriceLabel = true
        invokedUpdateCollectionPriceLabelCount += 1
    }

    var isInvokedUpdateTrackPriceLabel = false
    var invokedUpdateTrackPriceLabelCount = 0
    func updateTrackPriceLabel(text: String) {
        isInvokedUpdateTrackPriceLabel = true
        invokedUpdateTrackPriceLabelCount += 1
    }
    
    var isInvokedUpdateGenreNameLabel = false
    var invokedUpdateGenreNameLabelCount = 0
    func updateGenreNameLabel(text: String) {
        isInvokedUpdateGenreNameLabel = true
        invokedUpdateGenreNameLabelCount += 1
    }
    
    var isInvokedUpdateArtistNameLabel = false
    var invokedUpdateArtistNameLabelCount = 0
    func updateArtistNameLabel(text: String) {
        isInvokedUpdateArtistNameLabel = true
        invokedUpdateArtistNameLabelCount += 1
    }
    
    var isInvokedUpdateProgressBarView = false
    var invokedUpdateProgressBarViewCount = 0
    func updateProgressBarView(defaultTime: String) {
        isInvokedUpdateProgressBarView = true
        invokedUpdateProgressBarViewCount += 1
    }
    
    var isInvokedUpdateLikeImageButton = false
    var invokedUpdateLikeImageButtonCount = 0
    func updateLikeImageButton(isFavorite: Bool, normal: String, filled: String) {
        isInvokedUpdateLikeImageButton = true
        invokedUpdateLikeImageButtonCount += 1
    }
    
}

final class SingleSong {

    static var song: SongEntity {
        let bundle = Bundle(for: SearchPresenterTest.self)
        let path = bundle.path(forResource: "SearchResult", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SongsResultResponse.self, from: data)
        return Helper.shared.createFavorite(from: response.results![0])
    }
}
