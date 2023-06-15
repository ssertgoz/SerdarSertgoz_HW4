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
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 10
        static let cellRightPadding: Double = 10
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
    
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol?
    let router: DetaiRouterProtocol?
    private let interactor: DetailInteractorProtocol?
    private var isPlaying: Bool = false
    
    init(view: DetailViewControllerProtocol?, interactor: DetailInteractorProtocol, router: DetaiRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension DetailPresenter: DetailPresenterProtocol{
    func saveToFavorites() {
        guard let song = view?.getSource() else { return }
        self.interactor?.checkForSaveOrDelete(trackId: song.trackId)
        
    }
    
    
    func playMusic() {
        guard let song = view?.getSource() else { return }
        if isPlaying{
            interactor?.pauseMusic()
            view?.setPlayImage(false)
            view?.stopPlayAnimation()
            isPlaying = false
        }else{
            interactor?.playMusic(url: song.previewUrl ?? "")
            view?.setPlayImage(true)
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
        view?.updateProgressBarView()
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
        view?.updateLikeImageButton(isFavorite: !isFavorite)
    }
    
    func handleIsFavorite(isFavorite: Bool) {
        view?.updateLikeImageButton(isFavorite: isFavorite)
    }
    
    func handleUpdateProgress(elapsedTime: String,totalTime: String, progress: Double) {
        
        view?.startPlayAnimation(elapsedTime: elapsedTime,totalTime: totalTime, progress: progress)
        
    }
    
    func handleMusicDidEnd(){
        interactor?.pauseMusic()
        view?.setPlayImage(false)
        view?.stopPlayAnimation()
        isPlaying = false
    }
    
//    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>) {
//        view?.hideLoadingView()
//        switch result{
//        case .success(let result):
//            self.songs = result.results ?? []
//            view?.reloadData()
//        case .failure(let error):
//            view?.showError(error.localizedDescription)
//        }
//    }
    
    
}
