//
//  SongsResultResponse.swift
//  
//
//  Created by serdar on 8.06.2023.
//

import Foundation

public struct SongsResultResponse: Decodable {
    public let results: [Song]?
    public let resultCount: Int?

    private enum RootCodingKeys: String, CodingKey {
        case resultCount, results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Song].self, forKey: .results)
        self.resultCount = try container.decode(Int.self, forKey: .resultCount)
    }
}
