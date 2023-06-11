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
    func setImage(_ image: UIImage)
    func setPlayImage(_ isPlaying: Bool)
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double)
    func stopPlayAnimation()
}


class SongViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var playButon: UIButton!
    private var progressLayer: CAShapeLayer!
    private var circularPath: UIBezierPath!
    
    
    var cellPresenter: SongViewCellPresenterProtocol! {
            didSet {
                cellPresenter.load()
                self.layer.cornerRadius = 12
                image.layer.cornerRadius = 12
                self.contentView.isUserInteractionEnabled = true
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//                playImage.addGestureRecognizer(tapGesture)
//                playImage.isUserInteractionEnabled = true

            }
        }
    
//    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
//        cellPresenter.playMusic()
//    }

    @IBAction func onPlayButtonTapped(_ sender: UIButton) {
        cellPresenter.playMusic()
    }
    
    
}

extension SongViewCell: SongViewCellProtocol{
    func startPlayAnimation(startAngle: Double, endAngle: Double, progress: Double) {
        
//        progressLayer = CAShapeLayer()
//        progressLayer.strokeColor = UIColor.systemBlue.cgColor
//        progressLayer.lineWidth = 3.0
//        progressLayer.fillColor = UIColor.clear.cgColor
//        progressLayer.position = playImage.center
//        layer.addSublayer(progressLayer)
//        let center = playImage.center
//        let radius = playImage.frame.width / 2.0
//        circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        progressLayer.path = circularPath.cgPath
//
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.toValue = progress // Adjust the value to control the progress
//        animation.duration = 0.1 // Adjust the duration as needed
//        animation.fillMode = .removed
//        animation.isRemovedOnCompletion = true
//        progressLayer.add(animation, forKey: "progressAnimation")
    }
    
    func stopPlayAnimation() {
//        let center = playImage.center
//        let radius = playImage.frame.width / 2.0
//        let startAngle = CGFloat(-Double.pi / 2)
//        let endAngle = (2 * CGFloat(Double.pi))
//        circularPath.removeAllPoints()
//        progressLayer.removeFromSuperlayer()
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image.image = image
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

