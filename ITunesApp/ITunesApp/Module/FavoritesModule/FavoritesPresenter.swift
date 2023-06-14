//
//  FavoritesPresenter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import ITunesAPI

protocol FavoritesPresenterProtocol: AnyObject{
    func viewDidLoad()
    var numberOfItems: Int { get }
    func songAt(_ index: Int) -> Song?
    func didSelectRowAt(index: Int)
}

extension FavoritesPresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 10
        static let cellRightPadding: Double = 10
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
    
}

final class FavoritesPresenter{
    unowned var view: FavoritesViewControllerProtocol?
    let router: FavoritesRouterProtocol?
    private let interactor: FavoritesInteractorProtocol?
    private var favorites: [Song]?
    
    init(view: FavoritesViewControllerProtocol? = nil, router: FavoritesRouterProtocol?, interactor: FavoritesInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension FavoritesPresenter: FavoritesPresenterProtocol{
    func didSelectRowAt(index: Int) {
        //
    }
    
    func songAt(_ index: Int) -> Song? {
        return favorites?[index]
    }
    
    var numberOfItems: Int {
        return favorites?.count ?? 0
    }
    
    func viewDidLoad() {
        
        
        
    }
    
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol{
   
    
    
}
