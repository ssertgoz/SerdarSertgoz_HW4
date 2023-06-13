//
//  String+Extension.swift
//  ITunesApp
//
//  Created by serdar on 12.06.2023.
//

import Foundation

extension String {
    mutating func getHighResloutionImageUrl() {
        do {
            let regex = try NSRegularExpression(pattern: "100x100", options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "800x800")
        } catch { return }
    }
}
