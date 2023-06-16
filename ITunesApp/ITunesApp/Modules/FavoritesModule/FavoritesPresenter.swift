//
//  FavoritesPresenter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject{
    func viewDidLoad()
    func setNavigationBar() 
    var numberOfItems: Int { get }
    func songAt(index: Int) -> SongEntity?
    func didSelectRowAt(index: Int)
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) 
}

extension FavoritesPresenter {
    fileprivate enum Constants {
        static let cellCornerRadius: Double = 12
        static let cellHeightFactor: Double = 3.5
        static let navigationTitle: String = "Favorites"
        static let backButonText: String = "Back"
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
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        (collectionViewWidth, collectionViewWidth/Constants.cellHeightFactor)
    }
    
    func songAt(index: Int) -> SongEntity? {
        return favorites?[index]
    }
    
    var numberOfItems: Int {
        return favorites?.count ?? 0
    }
    
    func setNavigationBar() {
        self.view?.setNavigationBar(title: Constants.navigationTitle, backButtonText: Constants.backButonText)
    }
    
    func viewDidLoad() {
        self.view?.setupCollectionView()
        self.interactor?.fetchFavorites()
    }
    
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol{
    func handleFetchFavorites(favorites: [SongEntity]) {
        self.favorites = favorites.reversed()
        self.view?.reloadData()
    }
    
}
