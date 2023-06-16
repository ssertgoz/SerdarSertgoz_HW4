//
//  LoadingView.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import UIKit

final class LoadingView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIApplication.shared.windows.first?.frame ?? CGRect.zero
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        })
        
    }
    
    func handleOrientationChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let window = UIApplication.shared.windows.first else { return }
            self.blurView.frame = window.frame
            self.activityIndicator.center = self.blurView.center
        }
    }
    
}
