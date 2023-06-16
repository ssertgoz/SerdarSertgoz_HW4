//
//  SongViewCellInteractor.swift
//  ITunesApp
//
//  Created by serdar on 10.06.2023.
//

import Foundation
import MusicPlayer

protocol SongViewCellInteractorProtocol: AnyObject{
    func playMusic(url: String)
    func pauseMusic()
    func continueToPlay()
}

protocol SongViewCellInteractorOutputProtocol: AnyObject{
    func handleUpdateProgress(startAngle: Double, endAngle: Double, progress: Double)
    func handleMusicDidEnd()
}

fileprivate let musicPlayer: MusicPlayerProtocol = MusicPlayer.shared

final class SongViewCellInteractor{
    
    weak var output: SongViewCellInteractorOutputProtocol?
    private var timer: Timer?
    private var startAngle: Double!
    private var endAngle: Double!
    private var progress: Double!
    
    @objc func updateProgressView() {
        musicPlayer.getPlayer()?.volume = 1
        let currentTime =  Double(musicPlayer.getPlayer()?.currentItem?.currentTime().seconds ?? 0)
        let duration = Double(musicPlayer.getPlayer()?.currentItem?.duration.seconds ?? 0)
        startAngle = Double(-Double.pi / 2)
        progress = Double(currentTime / duration)
        endAngle = startAngle + (2 * Double(Double.pi) * progress)
        output?.handleUpdateProgress(startAngle: startAngle, endAngle: endAngle, progress: progress)
    }
    
    @objc func musicDidEnd() {
        output?.handleMusicDidEnd()
    }
    
}


extension SongViewCellInteractor: SongViewCellInteractorProtocol{
    func continueToPlay() {
        musicPlayer.continouToPlay()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
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
    
}
