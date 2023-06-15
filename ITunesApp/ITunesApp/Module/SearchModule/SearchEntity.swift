//
//  FavoritesEntity.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import CoreData

class SongEntity{
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

//class Favorite: NSManagedObject {
//    @NSManaged var trackId: Int64
//    @NSManaged var artistName: String?
//    @NSManaged var collectionName: String?
//    @NSManaged var trackName: String?
//    @NSManaged var previewUrl: String?
//    @NSManaged var artworkUrl100: String?
//    @NSManaged var collectionPrice: Double
//    @NSManaged var trackPrice: Double
//    @NSManaged var trackCount: Int
//    @NSManaged var trackNumber: Int
//    @NSManaged var currency: String?
//    @NSManaged var primaryGenreName: String?
//}

