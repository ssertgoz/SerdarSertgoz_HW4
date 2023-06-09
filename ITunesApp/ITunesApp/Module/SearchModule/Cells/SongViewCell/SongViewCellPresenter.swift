//
//  SongViewCellPresenter.swift
//  ITunesApp
//
//  Created by serdar on 9.06.2023.
//
import UIKit
import ITunesAPI
import ImageDownloader

protocol SongViewCellPresenterProtocol: AnyObject {
    func load()
}

final class SongViewCellPresenter {
    
    weak var view: SongViewCellProtocol?
    private let song: Song
    
    init(
        view: SongViewCellProtocol?,
        song: Song
    ){
        self.view = view
        self.song = song
    }
}

extension SongViewCellPresenter: SongViewCellPresenterProtocol {
    
    func load() {
        
        ImageDownloader.shared.image(
            url: "song",completion:
                { [weak self] data, error in
                    
                    guard let self else { return }
                    
                    if let data {
                        guard let img = UIImage(data: data) else { return }
                        self.view?.setImage(img)
                    }
                })
        
        view?.setArtistName(song.getArtist ?? "")
        view?.setTrackName(song.getTrack ?? "")
        view?.setCollectionName(song.getCollection ?? "")
        view?.setPlayImage(false)
        
    }
    
}
