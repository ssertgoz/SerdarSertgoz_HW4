//
//  DetailRouter.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit

final class DetailRouter{
    
    static func createModule() -> DetailViewController {
        let storyBoard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        let interactor = DetailInteractor()
        let preseneter = DetailPresenter(view: view, interactor: interactor)
        view?.presenter = preseneter
        interactor.output =  preseneter
        return view!
    }
}
