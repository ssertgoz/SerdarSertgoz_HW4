//
//  SongViewCell.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//

import UIKit

protocol SongViewCellProtocol: AnyObject{
    func setCornerRadius(radius: Double)
    func setArtistName(_ name: String)
    func setTrackName(_ name: String)
    func setCollectionName(_ name: String)
    func setImage(_ url: String?)
    func setPlayImage(_ isPlaying: Bool, stopImage: String, playImage: String)
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double, lineWiidth: Double, animationDuration: Double)
    func stopPlayAnimation()
    func handlePlayingIndexWhenFinish()
}

protocol SongViewCellDelegate {
    func onPlayButtonCliccked(indexPathOfCell: IndexPath, isPlaying: Bool)
}


final class SongViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    var indexPathOfCell: IndexPath!
    var isPlaying: Bool = false  {
        didSet{
            cellPresenter.load(isPlaying: isPlaying)
        }
    }
    var delegate: SongViewCellDelegate!
    
    
    var cellPresenter: SongViewCellPresenterProtocol! {
        didSet {
            cellPresenter.load(isPlaying: isPlaying)
            if(!isPlaying ){
                cellPresenter.pauseMusic(false)
            }
        }
    }
    
    @IBAction func onPlayButtonClicked(_ sender: Any) {
        delegate.onPlayButtonCliccked(indexPathOfCell: indexPathOfCell, isPlaying: isPlaying)
        cellPresenter.playMusic()
    }

}

extension SongViewCell: SongViewCellProtocol{
    func handlePlayingIndexWhenFinish() {
        DispatchQueue.main.async(execute: {
            self.delegate.onPlayButtonCliccked(indexPathOfCell: self.indexPathOfCell, isPlaying: false)
        })
    }
    
    func setCornerRadius(radius: Double) {
        cellView.layer.cornerRadius = radius
        image.layer.cornerRadius = radius
    }
    
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double, lineWiidth: Double, animationDuration: Double) {
        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = lineWiidth
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = playImage.center
        
        let radius = min(playImage.bounds.width, playImage.bounds.height) / 2.0
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 12, y: 5), radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        progressLayer.path = circularPath.cgPath
        
        layer.addSublayer(progressLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = progress
        animation.duration = animationDuration
        animation.fillMode = .removed
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "progressAnimation")
    }
    
    func stopPlayAnimation() {
        
        layer.sublayers?.forEach { layer in
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func setImage(_ url: String?) {
        if let url = URL(string: url ?? ""){
            DispatchQueue.main.async {
                self.image.sd_setImage(with: url)
            }
        }
        
    }
    
    func setPlayImage(_ isPlaying: Bool, stopImage: String, playImage: String) {
        
        DispatchQueue.main.async {
            
            if isPlaying {
                self.playImage.image = UIImage(systemName: stopImage)
            }
            else {
                self.playImage.image = UIImage(systemName: playImage)
            }
        }
        
    }
    
    func setArtistName(_ name: String) {
        self.artistNameLabel.text = name
    }
    
    func setTrackName(_ name: String) {
        self.trackNameLabel.text = name
    }
    
    func setCollectionName(_ name: String) {
        self.collectionNameLabel.text = name
    }
    
    
}

