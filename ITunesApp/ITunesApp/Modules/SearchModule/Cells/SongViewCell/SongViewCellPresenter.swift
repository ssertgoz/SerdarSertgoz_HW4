//
//  SongViewCellPresenter.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//
import UIKit

protocol SongViewCellPresenterProtocol: AnyObject {
    func load(isPlaying: Bool)
    func playMusic()
    func pauseMusic(_ isTapped: Bool)
}

extension SongViewCellPresenter {
    fileprivate enum Constants {
        static let cellCornerRadius: Double = 12
        static let lineWidgt: Double = 3.0
        static let aniamtionDuration: Double = 0.01
        static let stopImage: String = "stop.circle"
        static let playImage: String = "play.circle"
    }
}

final class SongViewCellPresenter {
    weak var view: SongViewCellProtocol?
    private let interactor: SongViewCellInteractorProtocol?
    private let song: SongEntity
    private var isPlaying: Bool = false
    
    init(
        view: SongViewCellProtocol?,
        interactor: SongViewCellInteractorProtocol,
        song: SongEntity
    ){
        self.view = view
        self.song = song
        self.interactor = interactor
    }
}

extension SongViewCellPresenter: SongViewCellPresenterProtocol {
    
    func pauseMusic(_ isTapped: Bool = true){
        if(isTapped){
            interactor?.pauseMusic()
        }
        view?.setPlayImage(false, stopImage: Constants.stopImage, playImage: Constants.playImage)
        view?.stopPlayAnimation()
        isPlaying = false
    }
    
    func playMusic() {
        if isPlaying{
            pauseMusic()
        }else{
            interactor?.playMusic(url: song.previewUrl ?? "")
            view?.setPlayImage(true, stopImage: Constants.stopImage, playImage: Constants.playImage)
            isPlaying = true
        }
    }
    
    func load(isPlaying: Bool) {
        view?.setImage(song.artworkUrl100)
        view?.setArtistName(song.artistName ?? "")
        view?.setTrackName(song.trackName ?? "")
        view?.setCollectionName(song.collectionName ?? "")
        view?.setCornerRadius(radius: Constants.cellCornerRadius)
        if(isPlaying){
            
            interactor?.continueToPlay()
        }
        view?.setPlayImage(isPlaying, stopImage: Constants.stopImage, playImage: Constants.playImage)
    }
    
}

extension SongViewCellPresenter: SongViewCellInteractorOutputProtocol{
    func handleUpdateProgress(startAngle: Double, endAngle: Double, progress: Double) {
        view?.startPlayAnimation(startAngle: startAngle, endAngle: endAngle, progress: progress, lineWiidth: Constants.lineWidgt, animationDuration: Constants.aniamtionDuration)
    }
    
    func handleMusicDidEnd(){
        interactor?.pauseMusic()
        view?.setPlayImage(false, stopImage: Constants.stopImage, playImage: Constants.playImage)
        view?.stopPlayAnimation()
        view?.handlePlayingIndexWhenFinish()
        isPlaying = false
    }
    
}
