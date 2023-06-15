//
//  Helper.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import ITunesAPI

class Helper{
    static let shared = Helper()
    
    func createFavorite(from song: Song) -> SongEntity {
        let favorite = SongEntity()
        favorite.trackId = song.getTrackId!
        favorite.artistName = song.getArtist
        favorite.collectionName = song.getCollection
        favorite.trackName = song.getTrack
        favorite.previewUrl = song.getPreviewURL
        favorite.artworkUrl100 = song.getArtworkURL
        favorite.collectionPrice = song.getCollectionPrice ?? 0
        favorite.trackPrice = song.getTrackPrice ?? 0
        favorite.trackCount = song.getTrackCount ?? 0
        favorite.trackNumber = song.getTrackNumber ?? 0
        favorite.currency = song.getCurrency
        favorite.primaryGenreName = song.getPrimaryGenre
        return favorite
    }


}
