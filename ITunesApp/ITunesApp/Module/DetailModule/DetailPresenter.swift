//
//  DetailPresenter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import SDWebImage

protocol DetailPresenterProtocol: AnyObject{
    func viewDidLoad()
    func playMusic()
    func saveToFavorites()
    
    func calculateProgressBarSize(width: Double) -> (width: Double, height: Double)
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let cellCornerRadius: Double = 12
        static let progressBarPadding: Double = 40
        static let progressBarHeight: Double = 35
        static let normalHeartImage: String = "heart"
        static let filledHeartImage: String = "heart.fill"
        static let defaultTime: String = "00:00"
        static let playImageName: String = "play.fill"
        static let stopImageName: String = "stop.fill"
    }
    
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol?
    private let interactor: DetailInteractorProtocol?
    private var isPlaying: Bool = false
    
    init(view: DetailViewControllerProtocol?, interactor: DetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol{
    func calculateProgressBarSize(width: Double) -> (width: Double, height: Double) {
        (width - Constants.progressBarPadding, Constants.progressBarHeight)
    }
    
    func saveToFavorites() {
        guard let song = view?.getSource() else { return }
        self.interactor?.checkForSaveOrDelete(trackId: song.trackId)
        
    }
    
    func playMusic() {
        guard let song = view?.getSource() else { return }
        if isPlaying{
            interactor?.pauseMusic()
            view?.setPlayImage(false, Constants.stopImageName, Constants.playImageName)
            view?.stopPlayAnimation( Constants.stopImageName, Constants.playImageName)
            isPlaying = false
        }else{
            interactor?.playMusic(url: song.previewUrl ?? "")
            view?.setPlayImage(true, Constants.stopImageName, Constants.playImageName)
            isPlaying = true
        }
        
    }
    
    func viewDidLoad() {
        guard let song = view?.getSource() else { return }
        var imgUrl = song.artworkUrl100
        imgUrl?.getHighResloutionImageUrl()
        view?.updateTrackImage(url: imgUrl!)
        view?.updateTrackNameLabel(text: song.trackName ?? "")
        view?.updateCollectionPriceLabel(text: String(song.collectionPrice ?? 0) + " " + (song.currency ?? ""))
        view?.updateTrackPriceLabel(text: String(song.trackPrice ?? 0) + " " + (song.currency ?? ""))
        view?.updateGenreNameLabel(text: song.primaryGenreName ?? "")
        view?.updateArtistNameLabel(text: song.artistName ?? "")
        view?.updateCollectionNameLabel(text: song.collectionName ?? "")
        view?.updateProgressBarView(defaultTime: Constants.defaultTime)
        view?.setTitle("")
        interactor?.isFavorite(trackId: song.trackId)
        
    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol{
    func handleCheckForSaveOrDelete(isFavorite: Bool) {
        guard let song = view?.getSource() else { return }
        if(!isFavorite){
            self.interactor?.saveToFavorites(favorite: song)
        }
        else{
            self.interactor?.deleteFromFavorites(trackId: song.trackId)
        }
        view?.updateLikeImageButton(isFavorite: !isFavorite, normal: Constants.normalHeartImage, filled: Constants.filledHeartImage)
    }
    
    func handleIsFavorite(isFavorite: Bool) {
        view?.updateLikeImageButton(isFavorite: isFavorite, normal: Constants.normalHeartImage, filled: Constants.filledHeartImage)
    }
    
    func handleUpdateProgress(elapsedTime: String,totalTime: String, progress: Double) {
        
        view?.startPlayAnimation(elapsedTime: elapsedTime,totalTime: totalTime, progress: progress)
        
    }
    
    func handleMusicDidEnd(){
        interactor?.pauseMusic()
        view?.setPlayImage(false, Constants.stopImageName, Constants.playImageName)
        view?.stopPlayAnimation(Constants.stopImageName, Constants.playImageName)
        isPlaying = false
    }
}
