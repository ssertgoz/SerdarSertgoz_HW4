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
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet var backgroundView: UIView!
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(heartButtonTapped))
        heartButton.tintColor = UIColor.white
            // Oluşturulan butonu navigationBar'ın sağ tarafına ekle
            navigationItem.rightBarButtonItem = heartButton
        collectionView.backgroundColor = UIColor.clear
        let colors: [UIColor] = [.black, .black.withAlphaComponent(0), .black.withAlphaComponent(0)]
        backgroundView.setGradientBackground(colors: colors)
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = .white.withAlphaComponent(0)
        presenter.viewDidLoad()
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
            cell.delegate = self
            cell.indexPath = indexPath
            cell.playingIndex = self.presenter.playingMusicIndex
            cell.setPlayImage(self.presenter.playingMusicIndex == indexPath.row ? true : false)
            interactor.output = presenter
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 120)
    }
    
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.load(text: searchText)
    }
}


extension SearchViewController: SearchViewControllerProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

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
            if self.presenter.numberOfItems == 0 {
                self.emptyView.isHidden = false
            } else {
                self.emptyView.isHidden = true
            }
        }
    }
}

extension SearchViewController: SongViewCellDelegate{
    func playButtonTapped(at indexPath: IndexPath) {
//        presenter.playingMusicIndex = indexPath.row
//        reloadData()
//        if(indexPath.row != presenter.playingMusicIndex){
//            //presenter.playingMusicIndex = indexPath.row
//            //reloadData()
//        }
        
        print(indexPath.row)
        
    }
    
    
}

