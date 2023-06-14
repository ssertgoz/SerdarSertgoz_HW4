//
//  FavoritesCollectionViewCellInteractor.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesCellInteractorProtocol: AnyObject{
}

protocol FavoritesCellInteractorOutputProtocol: AnyObject{

}


final class FavoritesCellInteractor{
    weak var output: FavoritesCellInteractorOutputProtocol?
}
    

extension FavoritesCellInteractor: FavoritesCellInteractorProtocol{

    
    
}
