//
//  SearchInteractor.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation
import ITunesAPI
import MusicPlayer

protocol SearchInteractorProtocol: AnyObject{
    func fetchSearchResults(text: String)
    func pauseMusic()
}

protocol SearchInteractorOutputProtocol: AnyObject{
    func handleSearchResult(_ result: Result<SongsResultResponse, NetworkError>)
}

fileprivate let service: ITunesServiceProtocol = API.shared
fileprivate let musicPlayer: MusicPlayerProtocol = MusicPlayer.shared

final class SearchInteractor{
    weak var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol{
    func pauseMusic() {
        musicPlayer.pause()
    }
    
    
    func fetchSearchResults(text: String) {
        
        service.fetchSearchResults(text: text) { [weak self] response in
            guard let self else {return}
            self.output?.handleSearchResult(response)
            
        }
    }
    
    
}
