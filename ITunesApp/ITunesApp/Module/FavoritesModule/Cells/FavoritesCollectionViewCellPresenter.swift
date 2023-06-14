//
//  FavoritesCollectionViewCellPresenter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import ITunesAPI

protocol FavoritesCellPresenterProtocol: AnyObject{
    func viewDidLoad()
}

extension FavoritesCellPresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 10
        static let cellRightPadding: Double = 10
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
    
}

final class FavoritesCellPresenter{
    unowned var view: FavoriteCollectionViewCellProtocol?
    private let interactor: FavoritesCellInteractorProtocol?
    private let song: Song!
    
    init(view: FavoriteCollectionViewCellProtocol? = nil,  interactor: FavoritesCellInteractorProtocol?, song: Song) {
        self.view = view
        self.interactor = interactor
        self.song = song
    }
}


extension FavoritesCellPresenter: FavoritesCellPresenterProtocol{
    func viewDidLoad() {
        view?.setImage(song.getArtworkURL)
        view?.setArtistName(song.getArtist ?? "")
        view?.setTrackName(song.getTrack ?? "")
        view?.setCollectionName(song.getCollection ?? "")
    }
    
}

extension FavoritesCellPresenter: FavoritesCellInteractorOutputProtocol{
   
    
    
}
