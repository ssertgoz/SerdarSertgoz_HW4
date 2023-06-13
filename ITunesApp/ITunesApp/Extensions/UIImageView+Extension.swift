//
//  UIImageView+Extension.swift
//  ITunesApp
//
//  Created by serdar on 12.06.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func applyShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0.0, height: 0.0), radius: CGFloat = 15.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
