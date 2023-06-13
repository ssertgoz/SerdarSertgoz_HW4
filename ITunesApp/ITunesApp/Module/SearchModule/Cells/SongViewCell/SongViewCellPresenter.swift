//
//  SongViewCellPresenter.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//
import UIKit
import ITunesAPI

protocol SongViewCellPresenterProtocol: AnyObject {
    func load()
    func playMusic()
    var getIsPlaying: Bool { get }
}

final class SongViewCellPresenter {
    static var playingTrackId: Double?
    
    weak var view: SongViewCellProtocol?
    private let interactor: SongViewCellInteractorProtocol?
    private let song: Song
    private var isPlaying: Bool = false
    
    init(
        view: SongViewCellProtocol?,
        interactor: SongViewCellInteractorProtocol,
        song: Song
    ){
        self.view = view
        self.song = song
        self.interactor = interactor
    }
}

extension SongViewCellPresenter: SongViewCellPresenterProtocol {
    var getIsPlaying: Bool {
        self.isPlaying
    }
    
    func playMusic() {
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
    
    
    func load() {
        
        view?.setImage(song.getArtworkURL)
        view?.setArtistName(song.getArtist ?? "")
        view?.setTrackName(song.getTrack ?? "")
        view?.setCollectionName(song.getCollection ?? "")
        
    }
    
}

extension SongViewCellPresenter: SongViewCellInteractorOutputProtocol{
    func handleUpdateProgress(startAngle: Double, endAngle: Double, progress: Double) {
        view?.startPlayAnimation(startAngle: startAngle, endAngle: endAngle, progress: progress)
    }
    
    func handleMusicDidEnd(){
        interactor?.pauseMusic()
        view?.setPlayImage(false)
        view?.stopPlayAnimation()
        isPlaying = false
    }
    
}
