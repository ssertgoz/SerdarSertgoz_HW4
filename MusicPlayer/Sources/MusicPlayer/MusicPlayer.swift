

import AVFoundation

public protocol MusicPlayerProtocol: AnyObject{
    func play(url: String)
    func pause()
    func getPlayer() -> AVPlayer?
}

public class MusicPlayer: MusicPlayerProtocol {
    public static let shared = MusicPlayer()
    private var player: AVPlayer?
    
    public init() {
    }
    
    public func play(url: String){
        guard let mp3URL = URL(string: url) else {
            return
        }
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: mp3URL)
        player = AVPlayer(playerItem: playerItem)
        player!.play()
    }
    
    public func pause(){
        player?.pause()
    }
    
    public func getPlayer() -> AVPlayer? {
        return player
    }
}
