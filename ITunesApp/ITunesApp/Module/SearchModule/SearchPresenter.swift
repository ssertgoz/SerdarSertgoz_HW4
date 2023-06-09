//
//  SearchPresenter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI

protocol SearchPresenterProtocol: AnyObject{
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    func load(text: String)
    func songAt(_ index: Int) -> Song?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
    func rowTapped(title: String)
}

extension SearchPresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 10
        static let cellRightPadding: Double = 10
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
    
}

final class SearchPresenter{
    private var songs: [Song] = []
    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol?
    private let interactor: SearchInteractorProtocol?
    
    init(view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension SearchPresenter: SearchPresenterProtocol{
    func load(text: String) {
        view?.showLoadingView()
        interactor?.fetchSearchResults(text: text)
    }
    
    var numberOfItems: Int {
        songs.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func songAt(_ index: Int) -> Song? {
        songs[index]
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        
        let cellWitdh = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWitdh * Constants.cellPosterImageRatio
        
        return (width: cellWitdh, height: Constants.cellTitleHeight + posterImageHeight)
    }
    
    func rowTapped(title: String) {
        //TODO
    }
    
    
}

extension SearchPresenter: SearchInteractorOutputProtocol{
    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>) {
        view?.hideLoadingView()
        switch result{
        case .success(let result):
            self.songs = result.results ?? []
            view?.reloadData()
        case .failure(let error):
            view?.showError(error.localizedDescription)
        }
    }
    
    
}
