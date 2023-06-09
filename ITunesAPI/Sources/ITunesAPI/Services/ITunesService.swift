//
//  DefinitionService.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

public protocol ITunesServiceProtocol {
    
    func fetchSearchResults(text: String, completion: @escaping (Result<SongsResultResponse, NetworkError>) -> Void)
}

extension API: ITunesServiceProtocol {
    
    public func fetchSearchResults(text: String, completion: @escaping (Result<SongsResultResponse, NetworkError>) -> Void) {
        executeRequestFor(parameters: ["text": text], completion: completion)
    }
    
}
