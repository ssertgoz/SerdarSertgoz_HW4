//
//  FavoritesRouter.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import UIKit

enum FavoritesRoutes {
    //case detailScreen(source: Int) //TODO: change
}

protocol FavoritesRouterProtocol{
    //func navigateToDetail(_ route: SearchRoutes)
}

final class FavoritesRouter{
    //private weak var searchCV: SearchViewController?
    
    static func createModule() -> FavoritesViewController {
        let storyBoard = UIStoryboard(name: "FavoritesViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let preseneter = FavoritesPresenter(view: view, router: router, interactor: interactor)
        view?.presenter = preseneter
        interactor.output =  preseneter
        return view!
    }
}

extension FavoritesRouter: FavoritesRouterProtocol{
//    func navigateToDetail(_ route: SearchRoutes) {
//        switch route {
//                case .detailScreen(let source):
//
//                    let detailVC = DetailRouter.createModule()
//                    detailVC.source = source
//                    viewController?.navigationController?.pushViewController(detailVC, animated: true)
//                }
//    }
    
}
