//
//  SearchPresenter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI

protocol SearchPresenterProtocol: AnyObject{
    func viewDidLoad()
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    var playingMusicIndex: Int { get set}
    func load(text: String)
    func songAt(_ index: Int) -> Song?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
    func didSelectRowAt(index: Int)
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
    private var playingIndex: Int?
    private let interactor: SearchInteractorProtocol?
    private var timer: Timer?
    
    init(view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension SearchPresenter: SearchPresenterProtocol{
    var playingMusicIndex: Int {
        get {
            self.playingIndex ?? -1
        }
        set {
            self.playingIndex = newValue
        }
    }
    
    
    
    func viewDidLoad() {
        view?.setupCollectionView()
        view?.setTitle("iTunes Search")
    }
    
    func load(text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.view?.showLoadingView()
            self.interactor?.fetchSearchResults(text: text)
        }
        
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
    
    func didSelectRowAt(index: Int) {
        guard let source = songAt(index) else { return }
        
        router?.navigateToDetail(.detailScreen(source: source))
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
