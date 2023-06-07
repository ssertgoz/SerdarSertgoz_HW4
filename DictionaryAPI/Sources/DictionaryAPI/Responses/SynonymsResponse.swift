//
//  SynonymsResponse.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

// I didnt use Decodable protocol since I do not need
public struct SynonymsResponse {
    public let result: [SynonymsResult]
    
    public init(data: Data) throws {
        let decoder = Decoders.jsonDecoder
        self.result = try decoder.decode([SynonymsResult].self, from: data)
    }
}
