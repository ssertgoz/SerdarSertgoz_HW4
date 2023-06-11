//
//  DetailRouter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit

enum DetailRoutes {
    //case detailScreen(source: Int) //TODO: change
}

protocol DetaiRouterProtocol{
    //func navigateToDetail(_ route: SearchRoutes)
}

final class DetailRouter{
    //private weak var searchCV: SearchViewController?
    
    static func createModule() -> DetailViewController {
        let storyBoard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let preseneter = DetailPresenter(view: view, interactor: interactor, router: router)
        view?.presenter = preseneter
        interactor.output =  preseneter
        return view!
    }
}

extension DetailRouter: DetaiRouterProtocol{
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
