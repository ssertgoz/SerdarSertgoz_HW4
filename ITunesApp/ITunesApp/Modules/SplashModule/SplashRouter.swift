//
//  SplashRouter.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//

import Foundation
import UIKit

enum SplashRoutes {
    case searchScreen
}

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}


final class SplashRouter {
    
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let storyBoard = UIStoryboard(name: "SplashViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController
         let interactor = SplashInteractor()
         let router = SplashRouter()
         let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view?.presenter = presenter
         interactor.output = presenter
         router.viewController = view
        return view!
     }
}

extension SplashRouter: SplashRouterProtocol {
    
    func navigate(_ route: SplashRoutes) {
        
        switch route {
        case .searchScreen:
            guard let window = viewController?.view.window else { return }
            let searchVC = SearchRouter.createModule()
            let navigationController = UINavigationController(rootViewController: searchVC)
            window.rootViewController = navigationController
            viewController?.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    
}
