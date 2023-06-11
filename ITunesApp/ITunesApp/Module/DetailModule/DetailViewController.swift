//
//  DetailViewController.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import UIKit
import ITunesAPI

protocol DetailViewControllerProtocol: AnyObject{
    
}

class DetailViewController: BaseViewController {

    
    var presenter: DetailPresenterProtocol!
    var source: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension DetailViewController: DetailViewControllerProtocol{
    
}
