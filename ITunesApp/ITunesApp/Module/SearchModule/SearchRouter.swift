//
//  SearchRouter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit

protocol SearchRouterProtocol{
    //func navigateToDetail(with id: String)
}

final class SearchRouter: SearchRouterProtocol{
    weak var navigationController: UINavigationController?
    private weak var searchCV: SearchViewController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> SearchViewController {
        let storyBoard = UIStoryboard(name: "SearchViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let preseneter = SearchPresenter(view: view, interactor: interactor, router: router)
        view?.presenter = preseneter
        interactor.output =  preseneter
        return view!
    }
}

extension SearchRouter{
}
