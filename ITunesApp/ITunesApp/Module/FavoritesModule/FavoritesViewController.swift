//
//  FavoritesViewController.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject{
    func setNavigationBar(title: String, backButtonText: String)
    func reloadData()
    func setupCollectionView()
}

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var emptyView: UIView!
    var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        if let song = presenter.songAt(index: indexPath.row){
            let presenter = FavoritesCellPresenter(view: cell, interactor: interactor, song: song)
            cell.cellPresenter = presenter
            cell.delegate = self
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

extension FavoritesViewController: FavoritesViewControllerProtocol{
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(cellType: FavoritesCollectionViewCell.self)
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
    
    func setNavigationBar(title: String, backButtonText: String) {
        self.title = title
        navigationController?.navigationBar.tintColor = UIColor.white
        backgroundView.setGradientBackground()
        let backButton = UIBarButtonItem()
        backButton.title = backButtonText
        navigationItem.backBarButtonItem = backButton
    }
}

extension FavoritesViewController: FavoritesCollectionViewCellDelegate{
    func onCollectionReloaded() {
        presenter.viewDidLoad()
        collectionView.reloadData()
    }
    
    
}
