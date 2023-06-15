//
//  FavoritesCollectionViewCellPresenter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesCellPresenterProtocol: AnyObject{
    func viewDidLoad()
    func deleteFromFavorites()
}

extension FavoritesCellPresenter {
    fileprivate enum Constants {
        static let cellCornerRadius: Double = 12
    }
    
}

final class FavoritesCellPresenter{
    unowned var view: FavoriteCollectionViewCellProtocol?
    private let interactor: FavoritesCellInteractorProtocol?
    private let song: SongEntity!
    
    init(view: FavoriteCollectionViewCellProtocol? = nil,  interactor: FavoritesCellInteractorProtocol?, song: SongEntity) {
        self.view = view
        self.interactor = interactor
        self.song = song
    }
}


extension FavoritesCellPresenter: FavoritesCellPresenterProtocol{
    func deleteFromFavorites() {
        self.interactor?.deleteFromFavorites(trackId: song.trackId)
        self.view?.reloadData()
    }
    
    func viewDidLoad() {
        view?.setImage(song.artworkUrl100)
        view?.setArtistName(song.artistName ?? "")
        view?.setTrackName(song.trackName ?? "")
        view?.setCollectionName(song.collectionName ?? "")
        view?.setCornerRadius(Constants.cellCornerRadius)
    }
    
}
