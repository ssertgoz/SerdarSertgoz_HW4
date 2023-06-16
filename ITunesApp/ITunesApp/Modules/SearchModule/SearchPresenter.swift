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
    func load(text: String)
    func songAt(_ index: Int) -> SongEntity?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
    func didSelectRowAt(index: Int)
    func favoritesButtonTapped()
    var playingIndexPath: IndexPath? { get set }
    var defaultIndex: Int { get }
    func reloadCollectionView()
    
}

extension SearchPresenter {
    fileprivate enum Constants {
        static let navigationTitle: String = "iTunes Search"
        static let cellCornerRadius: Double = 12
        static let favoriteImageName: String = "heart.fill"
        static let backButtonTitle: String = "Back"
        static let cellHeightFactor: Double = 3.5
        static let delayTime: Double = 0.5
        static let defaultIndexPathIndex = 1000 // indicates thet no music playing
    }
}

final class SearchPresenter{
    private var songs: [SongEntity] = []
    unowned var view: SearchViewControllerProtocol?
    let router: SearchRouterProtocol?
    private let interactor: SearchInteractorProtocol?
    private var timer: Timer?
    private var playingIndex: IndexPath?
    
    init(view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension SearchPresenter: SearchPresenterProtocol{
    func reloadCollectionView() {
        view?.reloadData()
    }
    
    var defaultIndex: Int {
        Constants.defaultIndexPathIndex
    }
    
    var playingIndexPath: IndexPath? {
        get {
            playingIndex
        }
        set {
            playingIndex = newValue
        }
    }
    
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        (collectionViewWidth, collectionViewWidth/Constants.cellHeightFactor)
    }
    
    func favoritesButtonTapped() {
        router?.navigateTo(.favoritesScreen)
    }
    
    func viewDidLoad() {
        view?.setupCollectionView()
        view?.setTitle(Constants.navigationTitle)
        view?.viewDidLoaded(backButtonTtile: Constants.backButtonTitle, favoritesImageName: Constants.favoriteImageName)
    }
    
    func load(text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Constants.delayTime, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.view?.showLoadingView()
            let replacedStr = text.replacingOccurrences(of: " ", with: "+")
            self.interactor?.fetchSearchResults(text: replacedStr)
        }
    }
    
    var numberOfItems: Int {
        songs.count
    }
    
    func songAt(_ index: Int) -> SongEntity? {
        songs[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = songAt(index) else { return }
        interactor?.pauseMusic()
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
