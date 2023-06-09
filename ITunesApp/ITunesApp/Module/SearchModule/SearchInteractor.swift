//
//  SearchInteractor.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI

protocol SearchInteractorProtocol: AnyObject{
    func fetchSearchResults(text: String)
}

protocol SearchInteractorOutputProtocol: AnyObject{
    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>)
}

typealias SearchResult = Result<[SongsResultResponse], Error>
fileprivate let service: ITunesServiceProtocol = API.shared

final class SearchInteractor{
    weak var output: SearchInteractorOutputProtocol?
}
    

extension SearchInteractor: SearchInteractorProtocol{
    
    func fetchSearchResults(text: String) {
        service.fetchSearchResults(text: text) { [weak self] response in
            guard let self else {return}
            self.output?.handleSearchResult(response)
            
        }
    }
    
    
}
