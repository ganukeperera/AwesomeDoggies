//
//  ManageFavourites.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/15/22.
//

import Foundation
import UIKit
import CoreData

class ManageFavourites{
    
    static let shared = ManageFavourites()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private(set) var favouriteItems = [Favourite]()
    
    private init() {
        loadFavourites()
    }
    
    func markFavourite(_ breed: Breed) {
        if checkExistance(breed.url) {
            deleteFavourite(breed)
            loadFavourites()
        }else{
            addFavourite(breed)
        }
    }
    
    func isMarkedFavourte(_ breed: Breed) -> Bool{
        return checkExistance(breed.url)
    }
}

//MARK: - CRUD
extension ManageFavourites {
    
    private func loadFavourites() {
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do{
            favouriteItems = try context.fetch(fetchRequest)
        }catch{
            print("Error occurred while getting favourites \(error.localizedDescription)")
        }
    }
    
    private func checkExistance(_ imageURL: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        let predicate = NSPredicate(format: "fileURL == %@", imageURL)
        fetchRequest.predicate = predicate
        var count: Int?
        do{
            count = try context.count(for: fetchRequest)
            
        }catch{
            print("Error occurred while searching for favourites \(error.localizedDescription)")
        }
        
        if count == NSNotFound {
            return true
        }
        if let count = count, count > 0 {
            return true
        }
        return false
    }
    
    private func addFavourite(_ breed: Breed) {
        
        let newFavourite = Favourite(context: context)
        
        newFavourite.fileURL = breed.url
        newFavourite.breed = breed.breed
        newFavourite.subBreed = breed.subBreed
        
        favouriteItems.append(newFavourite)
        
        saveItems()
    }
    
    private func deleteFavourite(_ breed: Breed) {
        let request: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        request.predicate = NSPredicate(format: "fileURL == %@", breed.url)
        do{
            let array = try context.fetch(request)
            
            for obj in array {
                context.delete(obj)
            }
        } catch {
            fatalError("Error occurred when deleting item \(error.localizedDescription)")
        }
        saveItems()
    }
    
    private func saveItems() {
        if !context.hasChanges {
            return
        }
        do{
            try context.save()
            
        } catch {
            fatalError("Error occurred while saving data to db \(error.localizedDescription)")
        }
    }
}
