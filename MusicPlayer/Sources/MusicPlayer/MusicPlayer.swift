

import AVFoundation

public protocol MusicPlayerProtocol: AnyObject{
    func play(url: String)
    func pause()
    func getPlayer() -> AVPlayer?
    func getTotalDuration() -> String?
    func getCurrentTime() -> String?
    func setCurentTime(second: Int, isForward: Bool)
    func continouToPlay()
}

public final class MusicPlayer: MusicPlayerProtocol {
    public static let shared = MusicPlayer()
    public var player: AVPlayer?
    
    public init() {
    }
    
    public func play(url: String){
        guard let mp3URL = URL(string: url) else {
            return
        }
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: mp3URL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    public func continouToPlay(){
        player?.play()
    }
    
    public func pause(){
        player?.pause()
    }
    
    public func getPlayer() -> AVPlayer? {
        return player
    }
    
    public func setCurentTime(second: Int, isForward: Bool){
        let time = player!.currentTime() // Get the current time of the player
        let timeToAdd = CMTime(seconds: isForward ? 5 : -5, preferredTimescale: time.timescale) // Create a CMTime object for 5 seconds
        let newTime = time + timeToAdd // Add it to the current time
        player!.seek(to: newTime)
        player!.play()
        
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

