//
//  Song.swift
//  
//
//  Created by serdar on 8.06.2023.
//

import Foundation

public struct Song: Decodable {
    let kind: String?
    let trackId: Double?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let trackCount: Int?
    let trackNumber: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let trackTimeMillis: Int?
    
    private enum CodingKeys: String, CodingKey {
        case kind, artistName, collectionName, trackName, previewUrl, artworkUrl100, collectionPrice,trackTimeMillis
        case trackPrice, releaseDate, trackCount, trackNumber, country, currency, primaryGenreName, trackId
    }
}
public extension Song {
    var getSongKind: String? {
        return kind
    }
    
    var getArtist: String? {
        return artistName
    }
    
    var getCollection: String? {
        return collectionName
    }
    
    var getTrack: String? {
        return trackName
    }
    
    var getPreviewURL: String? {
        return previewUrl
    }
    
    var getArtworkURL: String? {
        return artworkUrl100
    }
    
    var getCollectionPrice: Double? {
        return collectionPrice
    }
    
    var getTrackPrice: Double? {
        return trackPrice
    }
    
    var getReleaseDate: String? {
        return releaseDate
    }
    
    var getTrackCount: Int? {
        return trackCount
    }
    
    var getTrackNumber: Int? {
        return trackNumber
    }
    
    var getCountry: String? {
        return country
    }
    
    var getCurrency: String? {
        return currency
    }
    
    var getPrimaryGenre: String? {
        return primaryGenreName
    }
    
    var getTrackId: Double? {
        return trackId
    }
    
    //TODO: Kaldır
    
//    var getTrackTime: String? {
//        return formatMilliseconds(trackTimeMillis)
//    }
//
//    private func formatMilliseconds(_ milliseconds: Int?) -> String {
//        guard let milliseconds = milliseconds else { return "00:00"}
//        let totalSeconds = milliseconds / 1000
//        let minutes = (totalSeconds % 3600) / 60
//        let seconds = totalSeconds % 60
//
//        let formattedString = String(format: "%02d:%02d", minutes, seconds)
//        return formattedString
//    }
    
}
