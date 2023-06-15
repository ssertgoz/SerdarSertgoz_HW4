//
//  FavoritesInteractor.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject{
    func fetchFavorites()
    func saveFavorite(_ favorite: SongEntity)
    func isFavoriteExists(withTrackId trackId: Int)
}

protocol FavoritesInteractorOutputProtocol: AnyObject{
    func handleFetchFavorites(favorites: [SongEntity])
    func handleIsFavorite(isFavorite: Bool)
}

fileprivate let favoritesDB: FavoritesRepositoryProtocol = FavoriteRepository.shared

final class FavoritesInteractor{
    weak var output: FavoritesInteractorOutputProtocol?
}
    

extension FavoritesInteractor: FavoritesInteractorProtocol{
    func fetchFavorites()  {
        self.output?.handleFetchFavorites(favorites: favoritesDB.fetchFavorites())
        
    }
    
    func saveFavorite(_ favorite: SongEntity) {
        favoritesDB.saveFavorite(favorite)
    }
    
    func isFavoriteExists(withTrackId trackId: Int) {
        self.output?.handleIsFavorite(isFavorite: favoritesDB.isFavorite(withTrackId: trackId))
    }
    

    
    
}
