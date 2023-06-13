//
//  DetailPresenter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI
//import ImageDownloader
import SDWebImage

protocol DetailPresenterProtocol: AnyObject{
    func viewDidLoad()
    func playMusic()
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
    
    func playMusic() {
        guard let song = view?.getSource() else { return }
        if isPlaying{
            interactor?.pauseMusic()
            view?.setPlayImage(false)
            view?.stopPlayAnimation()
            isPlaying = false
        }else{
            interactor?.playMusic(url: song.getPreviewURL ?? "")
            view?.setPlayImage(true)
            isPlaying = true
        }
        
    }
    func viewDidLoad() {
        guard let song = view?.getSource() else { return }
        var imgUrl = song.getArtworkURL
        imgUrl?.getHighResloutionImageUrl()
        view?.updateTrackImage(url: imgUrl!)
        view?.updateTrackNameLabel(text: song.getTrack ?? "")
        view?.updateCollectionPriceLabel(text: String(song.getCollectionPrice ?? 0) + " " + (song.getCurrency ?? ""))
        view?.updateTrackPriceLabel(text: String(song.getTrackPrice ?? 0) + " " + (song.getCurrency ?? ""))
        view?.updateGenreNameLabel(text: song.getPrimaryGenre ?? "")
        view?.updateArtistNameLabel(text: song.getArtist ?? "")
        view?.updateCollectionNameLabel(text: song.getCollection ?? "")
        view?.updateProgressBarView()
        view?.setTitle("")
        
    }
    
}

extension DetailPresenter: DetailInteractorOutputProtocol{
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
