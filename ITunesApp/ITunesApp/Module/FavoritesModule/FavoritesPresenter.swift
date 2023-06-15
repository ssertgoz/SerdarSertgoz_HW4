//
//  FavoritesPresenter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject{
    func viewDidLoad()
    var numberOfItems: Int { get }
    func songAt(index: Int) -> SongEntity?
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
    private var favorites: [SongEntity]? = []
    
    init(view: FavoritesViewControllerProtocol? = nil, router: FavoritesRouterProtocol?, interactor: FavoritesInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}


extension FavoritesPresenter: FavoritesPresenterProtocol{
    func didSelectRowAt(index: Int) {
        guard let source = songAt(index: index) else { return }
        
        router?.navigateTo(.detailScreen(source: source))
    }
    
    func songAt(index: Int) -> SongEntity? {
        return favorites?[index]
    }
    
    var numberOfItems: Int {
        return favorites?.count ?? 0
    }
    
    func viewDidLoad() {
        self.view?.setTitle(title: "Favorites")
        self.view?.setupCollectionView()
        self.interactor?.fetchFavorites()
        
    }
    
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol{
    func handleFetchFavorites(favorites: [SongEntity]) {
        self.favorites = favorites.reversed()
        self.view?.reloadData()
        
    }
    
    func handleIsFavorite(isFavorite: Bool) {
        //
    }
    
    
    
    
}
