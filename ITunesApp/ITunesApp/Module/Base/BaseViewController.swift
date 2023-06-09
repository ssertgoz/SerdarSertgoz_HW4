//
//  BaseViewController.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, LoadingShowable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func showError(_ message: String) {
        showAlert("Error", message)
    }
    
}
