//
//  DefinitionService.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation
import Alamofire

fileprivate enum URLs : String{
    case searchURL = "https://itunes.apple.com/search?term="
    case searchDefaults = "&country=tr&media=music"
}

enum APIError: Error {
    case thereIsNoSuchAWordError
}

public protocol ITunesServiceProtocol: AnyObject {
    func fetchSearchRsults(text: String ,completion: @escaping (Result<[Song], Error>) -> Void)
}

public class ITunesService: ITunesServiceProtocol {
    
    public init() {}
    
    public func fetchSearchRsults(text: String ,completion: @escaping (Result<[Song], Error>) -> Void)  {
        AF.request(URLs.searchURL.rawValue + text + URLs.searchDefaults.rawValue).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let response = try decoder.decode(SongsResultResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(APIError.thereIsNoSuchAWordError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
