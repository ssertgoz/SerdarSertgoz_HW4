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


class SearchViewController: BaseViewController{
    
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
        if let song = presenter.songAt(indexPath.row){
            let presenter = SongViewCellPresenter(view: cell, interactor: interactor, song: song)
            cell.cellPresenter = presenter
            interactor.output = presenter
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.calculateCellHeight(collectionViewWidth: view.frame.width)
        return CGSize(width: size.width, height: size.height)
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

