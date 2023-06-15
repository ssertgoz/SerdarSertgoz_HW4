//
//  DetailInteractor.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import MusicPlayer


protocol DetailInteractorProtocol: AnyObject{
    func playMusic(url: String)
    func pauseMusic()
    func saveToFavorites(favorite: SongEntity)
    func isFavorite(trackId: Int)
    func checkForSaveOrDelete(trackId: Int)
    func deleteFromFavorites(trackId: Int)
}

protocol DetailInteractorOutputProtocol: AnyObject{
    func handleUpdateProgress(elapsedTime: String,totalTime: String, progress: Double)
    func handleMusicDidEnd()
    func handleIsFavorite(isFavorite: Bool)
    func handleCheckForSaveOrDelete(isFavorite: Bool)
}

fileprivate let musicPlayer: MusicPlayerProtocol = MusicPlayer.shared
fileprivate let favoritesRepository: FavoritesRepositoryProtocol = FavoriteRepository.shared

final class DetailInteractor{
    weak var output: DetailInteractorOutputProtocol?
    
    private var timer: Timer?
    private var progress: Double!
    
    @objc func updateProgressView() {
        musicPlayer.getPlayer()?.volume = 1
        let currentTime =  Double(musicPlayer.getPlayer()?.currentItem?.currentTime().seconds ?? 0)
        let duration = Double(musicPlayer.getPlayer()?.currentItem?.duration.seconds ?? 0)
        progress = Double(currentTime / duration)
        output?.handleUpdateProgress(elapsedTime:musicPlayer.getCurrentTime() ?? "00.00", totalTime: musicPlayer.getTotalDuration() ?? "00.00",progress: progress)
    }
}


extension DetailInteractor: DetailInteractorProtocol{
    func deleteFromFavorites(trackId: Int) {
        favoritesRepository.deleteFavorite(trackId: trackId)
    }
    
    func checkForSaveOrDelete(trackId: Int) {
        output?.handleCheckForSaveOrDelete(isFavorite: favoritesRepository.isFavorite(withTrackId: trackId))
    }
    
    func isFavorite(trackId: Int) {
        output?.handleIsFavorite(isFavorite: favoritesRepository.isFavorite(withTrackId: trackId))
    }
    
    func saveToFavorites(favorite: SongEntity) {
        favoritesRepository.saveFavorite(favorite)
    }
    
    func pauseMusic() {
        musicPlayer.pause()
        timer?.invalidate()
        timer = nil
    }
    
    func playMusic(url: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(musicDidEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        musicPlayer.play(url: url)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    
    @objc func musicDidEnd() {
        output?.handleMusicDidEnd()
    }
    
}
