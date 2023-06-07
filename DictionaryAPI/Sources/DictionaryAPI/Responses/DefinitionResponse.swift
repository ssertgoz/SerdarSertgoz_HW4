//
//  DefinitionResponse.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

// I didnt use Decodable protocol since I do not need but I used this response
// struct fetch only first element of given array which we need only.
public struct DefinitionResponse {
    public let result: DefinitionResult
    
    public init(data: Data) throws {
        let decoder = Decoders.jsonDecoder
        self.result = try decoder.decode([DefinitionResult].self, from: data)[0]
    }
}
