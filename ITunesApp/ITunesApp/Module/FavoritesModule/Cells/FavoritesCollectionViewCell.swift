//
//  FavoritesCollectionViewCell.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import UIKit

protocol FavoriteCollectionViewCellProtocol: AnyObject{
    func setArtistName(_ name: String)
    func setTrackName(_ name: String)
    func setCollectionName(_ name: String)
    func setImage(_ url: String?)
    func setLikeImage(_ isFavorite: Bool)
}

protocol FavoritesCollectionViewCellDelegate: AnyObject{
    
}

class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    weak var delegate: FavoritesCollectionViewCellDelegate?
    
    var cellPresenter: FavoritesCellPresenterProtocol! {
        didSet {
            cellPresenter.viewDidLoad()
            self.layer.cornerRadius = 12
            imageView.layer.cornerRadius = 12
            
        }
    }

    @IBAction func onLikeBUttonClicked(_ sender: Any) {
    }
}

extension FavoritesCollectionViewCell: FavoriteCollectionViewCellProtocol {
    func setImage(_ url: String?) {
        if let url = URL(string: url ?? ""){
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: url)
            }
        }
        
    }
    
    func setLikeImage(_ isFavorite: Bool) {
        DispatchQueue.main.async {
            if isFavorite {
                self.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
            }
            else {
                self.likeButton.imageView?.image = UIImage(systemName: "heart")
            }
        }
        
    }
    
    func setArtistName(_ name: String) {
        self.artistName.text = name
    }
    
    func setTrackName(_ name: String) {
        self.trackName.text = name
    }
    
    func setCollectionName(_ name: String) {
        self.collectionName.text = name
    }
}
