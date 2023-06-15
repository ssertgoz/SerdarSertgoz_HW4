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
}

protocol FavoritesInteractorOutputProtocol: AnyObject{
    func handleFetchFavorites(favorites: [SongEntity])
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
}
