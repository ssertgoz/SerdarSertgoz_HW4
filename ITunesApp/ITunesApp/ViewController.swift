//
//  ViewController.swift
//  ITunesApp
//
//  Created by serdar on 7.06.2023.
//

import UIKit
import ITunesAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = ITunesService()
        service.fetchSearchRsults(text: "tarkan") { response in
            switch response {
            case .success(let results):
                print(results)
            case .failure(_):
                print("")
                
            }
        }
        
    }


}

