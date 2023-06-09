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
    func reloadData()
    func showError(_ message: String)
    func setTitle(_ title: String)
    func setupCollectionView()
}

class SearchViewController: BaseViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load(text: "tarkan")
        
    }
    
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeCell(cellType: SongViewCell.self, indexPath: indexPath)
        cell.configure(artistName: presenter.songAt(indexPath.row)., trackName: <#T##String#>, collectionName: <#T##String#>, isPlaying: <#T##Bool#>)
    }
    
    
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: SongViewCell.self)
    }
    
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
        print(presenter.songAt(1))
    }
}

