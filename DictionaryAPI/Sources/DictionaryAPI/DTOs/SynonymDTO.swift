//
//  SynonymDTO.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

public struct SynonymsResult: Decodable{
    public let word: String?
    public let score: Int?
    
    enum CodingKeys: String, CodingKey {
        case word, score
    }
}
