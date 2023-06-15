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
    func songAt(_ index: Int) -> SongEntity?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
    func didSelectRowAt(index: Int)
    func favoritesButtonTapped()
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
    private var songs: [SongEntity] = []
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
    func favoritesButtonTapped() {
        router?.navigateTo(.favoritesScreen)
    }
    
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.view?.showLoadingView()
            let replacedStr = text.replacingOccurrences(of: " ", with: "+")
            self.interactor?.fetchSearchResults(text: replacedStr)
        }
        
    }
    
    var numberOfItems: Int {
        songs.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func songAt(_ index: Int) -> SongEntity? {
        songs[index]
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        
        let cellWitdh = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWitdh * Constants.cellPosterImageRatio
        
        return (width: cellWitdh, height: Constants.cellTitleHeight + posterImageHeight)
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = songAt(index) else { return }
        
        router?.navigateTo(.detailScreen(source: source))
    }
    
    
}

extension SearchPresenter: SearchInteractorOutputProtocol{
    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>) {
        view?.hideLoadingView()
        switch result{
        case .success(let result):
            self.songs.removeAll()
            result.results!.forEach { song in
                self.songs.append(Helper.shared.createFavorite(from: song) )
            }

            view?.reloadData()
        case .failure(let error):
            view?.showError(error.localizedDescription)
        }
    }
    
    
}
