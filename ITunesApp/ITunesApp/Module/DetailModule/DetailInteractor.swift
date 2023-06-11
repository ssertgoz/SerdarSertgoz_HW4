//
//  DetailInteractor.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation


protocol DetailInteractorProtocol: AnyObject{
    //func fetchSearchResults(text: String)
}

protocol DetailInteractorOutputProtocol: AnyObject{
    //func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>)
}


final class DetailInteractor{
    weak var output: DetailInteractorOutputProtocol?
}
    

extension DetailInteractor: DetailInteractorProtocol{
    
//    func fetchSearchResults(text: String) {
//        service.fetchSearchResults(text: text) { [weak self] response in
//            guard let self else {return}
//            self.output?.handleSearchResult(response)
//            
//        }
//    }
    
    
}
