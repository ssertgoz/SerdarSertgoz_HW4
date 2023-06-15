//
//  FavoritesCollectionViewCellInteractor.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesCellInteractorProtocol: AnyObject{
    func deleteFromFavorites(trackId: Int)
}

fileprivate let favoritesRepository: FavoritesRepositoryProtocol = FavoriteRepository.shared

final class FavoritesCellInteractor: FavoritesCellInteractorProtocol{
    func deleteFromFavorites(trackId: Int) {
        favoritesRepository.deleteFavorite(trackId: trackId)
    }
}
