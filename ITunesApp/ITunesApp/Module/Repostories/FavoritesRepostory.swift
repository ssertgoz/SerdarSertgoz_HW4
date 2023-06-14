//
//  FavoritesRepostory.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import CoreData

class CoreDataRepostory {
    
    static let shared = CoreDataRepostory()
    
    private init() {}
    
    // Favorites'ı çekme
    func fetchFavorites() -> [Favorite] {
        guard let context = getContext() else {
            return []
        }
        
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print("Error fetching favorites: \(error)")
            return []
        }
    }
    
    // Favorite kaydetme
    func saveFavorite(trackId: Double, artistName: String, collectionName: String, trackName: String, previewUrl: String, artworkUrl100: String, collectionPrice: Double, trackPrice: Double, trackCount: Int, trackNumber: Int, currency: String, primaryGenreName: String) {
        guard let context = getContext() else {
            return
        }
        
        let favorite = Favorite(context: context)
        favorite.trackId = trackId
        favorite.artistName = artistName
        favorite.collectionName = collectionName
        favorite.trackName = trackName
        favorite.previewUrl = previewUrl
        favorite.artworkUrl100 = artworkUrl100
        favorite.collectionPrice = collectionPrice
        favorite.trackPrice = trackPrice
        favorite.trackCount = trackCount
        favorite.trackNumber = trackNumber
        favorite.currency = currency
        favorite.primaryGenreName = primaryGenreName
        
        do {
            try context.save()
            print("Favorite saved successfully")
        } catch {
            print("Error saving favorite: \(error)")
        }
    }
    
    // Favorite kontrolü
    func isFavorite(trackId: Double) -> Bool {
        guard let context = getContext() else {
            return false
        }
        
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackId == %@", trackId as NSNumber)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite: \(error)")
            return false
        }
    }
    
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
}
