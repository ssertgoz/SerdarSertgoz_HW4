//
//  Song.swift
//  
//
//  Created by serdar on 8.06.2023.
//

import Foundation

public struct Song: Decodable {
    let kind: String?
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
    
    private enum CodingKeys: String, CodingKey {
        case kind, artistName, collectionName, trackName, previewUrl, artworkUrl100, collectionPrice
        case trackPrice, releaseDate, trackCount, trackNumber, country, currency, primaryGenreName
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
}
