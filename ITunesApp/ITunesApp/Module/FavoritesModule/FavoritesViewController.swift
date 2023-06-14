//
//  FavoritesViewController.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject{
}

class FavoritesViewController: UIViewController, FavoritesCollectionViewCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: FavoritesCollectionViewCell.self, indexPath: indexPath)
        let interactor = FavoritesCellInteractor()
        if let song = presenter.songAt(indexPath.row){
            let presenter = FavoritesCellPresenter(view: cell, interactor: interactor, song: song)
            cell.cellPresenter = presenter
            cell.delegate = self
            interactor.output = presenter 
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol{
    
}
