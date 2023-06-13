

import AVFoundation

public protocol MusicPlayerProtocol: AnyObject{
    func play(url: String)
    func pause()
    func getPlayer() -> AVPlayer?
    func getTotalDuration() -> String?
    func getCurrentTime() -> String?
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
    
    public func getTotalDuration() -> String? {
        return formatTime(player?.currentItem?.duration)
    }
    
    // Geçen süreyi elde etmek için
    public func getCurrentTime() -> String? {
        return formatTime(player?.currentItem?.currentTime())
    }
    
    // Zamanı biçimlendirmek için bir yardımcı fonksiyon
    private func formatTime(_ time: CMTime?) -> String? {
        guard let time = time else {return nil}
        var totalSeconds = CMTimeGetSeconds(time)
        if totalSeconds.isFinite {
            totalSeconds = Double(totalSeconds)
            // intValue'yi kullan
        } else {
            totalSeconds = 0
        }
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
}

