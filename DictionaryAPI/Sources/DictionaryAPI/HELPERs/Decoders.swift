//
//  Decoders.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

public enum Decoders {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
