//
//  FavoritesEntity.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import CoreData

final class SongEntity{
    var kind: String?
    var trackId: Int
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl100: String?
    var collectionPrice: Double?
    var trackPrice: Double?
    var releaseDate: String?
    var trackCount: Int?
    var trackNumber: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    
    init(kind: String? = nil, trackId: Int? = 0, artistName: String? = nil, collectionName: String? = nil, trackName: String? = nil, previewUrl: String? = nil, artworkUrl100: String? = nil, collectionPrice: Double? = nil, trackPrice: Double? = nil, releaseDate: String? = nil, trackCount: Int? = nil, trackNumber: Int? = nil, country: String? = nil, currency: String? = nil, primaryGenreName: String? = nil) {
        self.kind = kind
        self.trackId = trackId!
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.previewUrl = previewUrl
        self.artworkUrl100 = artworkUrl100
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.trackCount = trackCount
        self.trackNumber = trackNumber
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
    }
}
