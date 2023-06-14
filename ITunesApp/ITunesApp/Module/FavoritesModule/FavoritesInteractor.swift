//
//  FavoritesInteractor.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject{
}

protocol FavoritesInteractorOutputProtocol: AnyObject{

}


final class FavoritesInteractor{
    weak var output: FavoritesInteractorOutputProtocol?
}
    

extension FavoritesInteractor: FavoritesInteractorProtocol{

    
    
}
