//
//  SearchViewController.swift
//  ITunesApp
//
//  Created by serdar on 7.06.2023.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func showError(_ message: String)
    func reloadData()
    func setTitle(_ title: String)
    func setupCollectionView()
    func viewDidLoaded(backButtonTtile: String, favoritesImageName: String)
}


final class SearchViewController: BaseViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var presenter: SearchPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setAccessiblityIdentifiers()
    }
    
    
    @objc private func heartButtonTapped() {
        presenter.favoritesButtonTapped()
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: SongViewCell.self, indexPath: indexPath)
        let interactor = SongViewCellInteractor()
        if(self.presenter.playingIndexPath == nil){
            presenter.playingIndexPath = indexPath
            presenter.playingIndexPath?.row = presenter.defaultIndex
        }
        if let song = presenter.songAt(indexPath.row){
            let presenter = SongViewCellPresenter(view: cell, interactor: interactor, song: song)
            cell.cellPresenter = presenter
            interactor.output = presenter
            cell.delegate = self
            cell.indexPathOfCell = indexPath
            cell.isPlaying = indexPath.row == self.presenter.playingIndexPath?.row
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.playingIndexPath?.row = presenter.defaultIndex
        presenter.reloadCollectionView()
        presenter.didSelectRowAt(index: indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.calculateCellHeight(collectionViewWidth: view.frame.width)
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(presenter.playingIndexPath?.row == indexPath.row){
            (cell as! SongViewCell).isPlaying = true
        }
        else {
            (cell as! SongViewCell).isPlaying = false
        }
    }
    
    
}

extension SearchViewController: SongViewCellDelegate {
    func onPlayButtonCliccked(indexPathOfCell: IndexPath, isPlaying: Bool) {
        if(!isPlaying && presenter.playingIndexPath?.row != indexPathOfCell.row){
            let indexPathsToReload = collectionView.indexPathsForVisibleItems.filter { $0 == presenter.playingIndexPath }
            presenter.playingIndexPath = indexPathOfCell
            collectionView.reloadItems(at: indexPathsToReload)
        }
        else {
            presenter.playingIndexPath = indexPathOfCell
            presenter.playingIndexPath?.row = presenter.defaultIndex
            presenter.reloadCollectionView()
        }
        
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.load(text: searchText)
    }
}


extension SearchViewController: SearchViewControllerProtocol {
    func viewDidLoaded(backButtonTtile: String, favoritesImageName: String) {
        let heartButton = UIBarButtonItem(image: UIImage(systemName: favoritesImageName), style: .plain, target: self, action: #selector(heartButtonTapped))
        heartButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = heartButton
        
        backgroundView.setGradientBackground()
        
        let backButton = UIBarButtonItem()
        backButton.title = backButtonTtile
        navigationItem.backBarButtonItem = backButton
    }
    
    
    func setTitle(_ title: String) {
        self.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(cellType: SongViewCell.self)
        
    }
    
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
            if self.presenter.numberOfItems == 0 {
                self.emptyView.isHidden = false
            } else {
                self.emptyView.isHidden = true
            }
        }
    }
}


extension SearchViewController {
    
    private func setAccessiblityIdentifiers() {
        searchBar.accessibilityIdentifier = "searchBarIdentifier"
        collectionView.accessibilityIdentifier = "collectionview"
        emptyView.accessibilityIdentifier = "emptyview"
        backgroundView.accessibilityIdentifier = "backgroundview"
    }
    
}

