//
//  UIView+Extension.swift
//  ITunesApp
//
//  Created by serdar on 12.06.2023.
//

import Foundation

import UIKit

extension UIView {
    func setGradientBackground(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
