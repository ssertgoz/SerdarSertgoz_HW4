//
//  SplashPresenter.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//

import Foundation


protocol SplashPresenterProtocol: AnyObject{
    func viewDidAppear()
    
}

final class SplashPresenter: SplashPresenterProtocol{
    
    
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol!, router: SplashRouterProtocol!, interactor: SplashInteractorProtocol!) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
     
}

extension SplashPresenter: SplashInteractorOutputProtocol{
    func internetConnection(status: Bool) {
        if status{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.router.navigate(.searchScreen)
            })
        } else {
            view.noInternetConnection()
        }
    }
    
    
}
