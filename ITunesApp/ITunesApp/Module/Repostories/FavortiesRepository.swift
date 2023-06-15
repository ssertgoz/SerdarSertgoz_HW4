//
//  FavoritesRepostory.swift
//  ITunesApp
//
//  Created by serdar on 14.06.2023.
//

import Foundation
import UIKit
import CoreData

protocol FavoritesRepositoryProtocol{
    func fetchFavorites() -> [SongEntity]
    func saveFavorite(_ favoriteItem: SongEntity)
    func isFavorite(withTrackId trackId: Int) -> Bool
    func deleteFavorite(trackId: Int)
}

class FavoriteRepository : FavoritesRepositoryProtocol{
    
    static let shared = FavoriteRepository()
    
    private init() {}
    
    private var managedObjectContext: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate is not available")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveFavorite(_ favoriteItem: SongEntity) {
        if(!isFavorite(withTrackId: favoriteItem.trackId)){
            let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: managedObjectContext)
            
            favorite.setValue(favoriteItem.trackId, forKey: "trackId")
            favorite.setValue(favoriteItem.artistName, forKey: "artistName")
            favorite.setValue(favoriteItem.collectionName, forKey: "collectionName")
            favorite.setValue(favoriteItem.trackName, forKey: "trackName")
            favorite.setValue(favoriteItem.previewUrl, forKey: "previewUrl")
            favorite.setValue(favoriteItem.artworkUrl100, forKey: "artworkUrl100")
            favorite.setValue(favoriteItem.collectionPrice, forKey: "collectionPrice")
            favorite.setValue(favoriteItem.trackPrice, forKey: "trackPrice")
            favorite.setValue(favoriteItem.trackCount, forKey: "trackCount")
            favorite.setValue(favoriteItem.trackNumber, forKey: "trackNumber")
            
            favorite.setValue(favoriteItem.currency, forKey: "currency")
            favorite.setValue(favoriteItem.primaryGenreName, forKey: "primaryGenreName")
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Error saving favorite: \(error)")
            }
        }
    }
    
    func deleteFavorite(trackId: Int) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "trackId = %@", NSNumber(value: trackId))
        fetchRequest.fetchLimit = 1
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print("Error deleting favorite: \(error)")
        }
    }
    
    func isFavorite(withTrackId trackId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "trackId = %@", NSNumber(value: trackId))
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite: \(error)")
            return false
        }
    }
    
    func fetchFavorites() -> [SongEntity] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(value: true)
        
        do {
            let favorites = try managedObjectContext.fetch(fetchRequest)
            var favoriteArray = [SongEntity]()
            for favorite in favorites {
                let favoriteObject = SongEntity(
                    trackId: favorite.value(forKey: "trackId") as? Int,
                    artistName: favorite.value(forKey: "artistName") as? String,
                    collectionName: favorite.value(forKey: "collectionName") as? String,
                    trackName: favorite.value(forKey: "trackName") as? String,
                    previewUrl: favorite.value(forKey: "previewUrl") as? String,
                    artworkUrl100: favorite.value(forKey: "artworkUrl100") as? String,
                    collectionPrice: favorite.value(forKey: "collectionPrice") as? Double,
                    trackPrice: favorite.value(forKey: "trackPrice") as? Double,
                    trackCount: favorite.value(forKey: "trackCount") as? Int,
                    trackNumber: favorite.value(forKey: "trackNumber") as? Int,
                    currency: favorite.value(forKey: "currency") as? String,
                    primaryGenreName: favorite.value(forKey: "primaryGenreName") as? String
                )
                favoriteArray.append(favoriteObject)
            }
            return favoriteArray
        } catch {
            print("Error fetching favorites: \(error)")
            return []
        }
    }
}
