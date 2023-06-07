//
//  DefinitionService.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation
import Alamofire

fileprivate enum URLs : String{
    case definitionURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    case synonymsURL = "https://api.datamuse.com/words?rel_syn="
}

enum APIError: Error {
    case thereIsNoSuchAWordError
}

public protocol DictionaryServiceProtocol: AnyObject {
    func fetchDefinition(word: String ,completion: @escaping (Result<DefinitionResult, Error>) -> Void)
    func fetchSynonyms(word: String ,completion: @escaping (Result<[SynonymsResult], Error>) -> Void)
}

public class DictionaryService: DictionaryServiceProtocol {
    
    public init() {}
    
    public func fetchSynonyms(word: String ,completion: @escaping (Result<[SynonymsResult], Error>) -> Void)  {
        AF.request(URLs.synonymsURL.rawValue + word).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try SynonymsResponse(data: data)
                    completion(.success(response.result))
                } catch {
                    completion(.failure(APIError.thereIsNoSuchAWordError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    public func fetchDefinition(word: String ,completion: @escaping (Result<DefinitionResult, Error>) -> Void) {
        
        AF.request(URLs.definitionURL.rawValue + word).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try DefinitionResponse(data: data)
                    completion(.success(response.result))
                } catch {
                    completion(.failure(APIError.thereIsNoSuchAWordError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
