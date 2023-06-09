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
}


class SongViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    
    var cellPresenter: SongViewCellPresenterProtocol! {
            didSet {
                cellPresenter.load()
            }
        }
    
}

extension SongViewCell: SongViewCellProtocol{
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image.image = image
        }
    }
    
    func setPlayImage(_ isPlaying: Bool) {
        DispatchQueue.main.async {
            if isPlaying {
                self.playImage.image = UIImage(systemName: "pause.circle")
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
