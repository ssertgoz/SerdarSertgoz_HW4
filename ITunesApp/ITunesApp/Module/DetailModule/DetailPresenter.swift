//
//  DetailPresenter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI

protocol DetailPresenterProtocol: AnyObject{
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 10
        static let cellRightPadding: Double = 10
        static let cellPosterImageRatio: Double = 1/2
        static let cellTitleHeight: Double = 60
    }
    
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol?
    let router: DetaiRouterProtocol?
    private let interactor: DetailInteractorProtocol?
    
    init(view: DetailViewControllerProtocol?, interactor: DetailInteractorProtocol, router: DetaiRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension DetailPresenter: DetailPresenterProtocol{
    
//    func viewDidLoad() {
//        view?.setupCollectionView()
//        view?.setTitle("iTunes Search")
//    }
//
//    func load(text: String) {
//        view?.showLoadingView()
//        interactor?.fetchSearchResults(text: text)
//    }
//
//    var numberOfItems: Int {
//        songs.count
//    }
//
//    var cellPadding: Double {
//        Constants.cellLeftPadding
//    }
//
//    func songAt(_ index: Int) -> Song? {
//        songs[index]
//    }
//
//    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
//
//        let cellWitdh = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
//        let posterImageHeight = cellWitdh * Constants.cellPosterImageRatio
//
//        return (width: cellWitdh, height: Constants.cellTitleHeight + posterImageHeight)
//    }
//
//    func didSelectRowAt(index: Int) {
////            guard let source = songAt(index) else { return }
////            router.navigate(.detail(source: source))
//        }
    
    
}

extension DetailPresenter: DetailInteractorOutputProtocol{
//    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>) {
//        view?.hideLoadingView()
//        switch result{
//        case .success(let result):
//            self.songs = result.results ?? []
//            view?.reloadData()
//        case .failure(let error):
//            view?.showError(error.localizedDescription)
//        }
//    }
    
    
}
