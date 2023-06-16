//
//  FavoritesRouter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import UIKit

enum FavoritesRoutes {
    case detailScreen(source: SongEntity) 
}

protocol FavoritesRouterProtocol{
    func navigateTo(_ route: FavoritesRoutes)
}

final class FavoritesRouter{
    private weak var favoritesVC: FavoritesViewController?
    
    static func createModule() -> FavoritesViewController {
        let storyBoard = UIStoryboard(name: "FavoritesViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let preseneter = FavoritesPresenter(view: view, router: router, interactor: interactor)
        view?.presenter = preseneter
        interactor.output =  preseneter
        router.favoritesVC = view
        return view!
    }
}

extension FavoritesRouter: FavoritesRouterProtocol{
    func navigateTo(_ route: FavoritesRoutes) {
        switch route {
        case .detailScreen(let source):
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            favoritesVC?.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    
}
