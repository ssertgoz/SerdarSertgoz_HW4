//
//  SearchRouter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit
import ITunesAPI

enum SearchRoutes {
    case detailScreen(source: Song) //TODO: change
}

protocol SearchRouterProtocol{
    func navigateToDetail(_ route: SearchRoutes)
}

final class SearchRouter{
    private weak var searchVC: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let storyBoard = UIStoryboard(name: "SearchViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let preseneter = SearchPresenter(view: view, interactor: interactor, router: router)
        view?.presenter = preseneter
        interactor.output =  preseneter
        router.searchVC = view
        
        return view!
    }
}

extension SearchRouter: SearchRouterProtocol{
    func navigateToDetail(_ route: SearchRoutes) {
        switch route {
        case .detailScreen(let source):
            print("test4")
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            searchVC?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
