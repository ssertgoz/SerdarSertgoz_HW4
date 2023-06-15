//
//  SongViewCell.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//

import UIKit

protocol SongViewCellProtocol: AnyObject{
    func setArtistName(_ name: String)
    func setTrackName(_ name: String)
    func setCollectionName(_ name: String)
    func setImage(_ url: String?)
    func setPlayImage(_ isPlaying: Bool)
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double)
    func stopPlayAnimation()
}

protocol SongViewCellDelegate: AnyObject {
    func playButtonTapped(at indexPath: IndexPath)
}


class SongViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    weak var delegate: SongViewCellDelegate?
    var indexPath: IndexPath?
    var playingIndex: Int?
    
    
    var cellPresenter: SongViewCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
            
            cellView.layer.cornerRadius = 12
            image.layer.cornerRadius = 12
            self.contentView.isUserInteractionEnabled = true //TODO: kaldır
            //TODO: BUrayı aktif et
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            playImage.addGestureRecognizer(tapGesture)
            
        }
    }
    
    @IBAction func onPlayButtonClicked(_ sender: Any) {
        cellPresenter.playMusic()
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            print("geldi")
            cellPresenter.playMusic()
        }

    
    
}

extension SongViewCell: SongViewCellProtocol{
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double) {
        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = 3.0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = playImage.center
        
        let radius = min(playImage.bounds.width, playImage.bounds.height) / 2.0
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 12, y: 5), radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        progressLayer.path = circularPath.cgPath
        
        layer.addSublayer(progressLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = progress // Adjust the value to control the progress
        animation.duration = 0.01 // Adjust the duration as needed
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
    
    func setPlayImage(_ isPlaying: Bool) {
        DispatchQueue.main.async {
            if isPlaying {
                self.playImage.image = UIImage(systemName: "stop.circle")
            }
            else {
                self.playImage.image = UIImage(systemName: "play.circle")
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

