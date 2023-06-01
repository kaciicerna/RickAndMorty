//
//  CharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 28.05.2023.
//

import SwiftUI
import URLImage
import CoreData

class DetailCharacterViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isFavorite: Bool = false
    
    private let favoritesManager: FavoritesManager
    private let managedObjectContext: NSManagedObjectContext

    init(character: Character?, favoritesManager: FavoritesManager, managedObjectContext: NSManagedObjectContext) {
        self.character = character
        self.favoritesManager = favoritesManager
        self.managedObjectContext = managedObjectContext
        updateFavoriteStatus()
    }
    
    func updateFavoriteStatus() {
        guard let character = character else {
            isFavorite = false
            return
        }
        isFavorite = favoritesManager.isFavorite(character)
    }
    
    func toggleFavorite() {
        guard let character = character else {
            return
        }
        if isFavorite {
            favoritesManager.removeFavorite(character)
        } else {
            favoritesManager.addFavorite(character)
            saveFavoriteCharacter()
            print("Saved")
        }
        updateFavoriteStatus()
    }
    
    private func saveFavoriteCharacter() {
        guard let character = character else {
            return
        }
        
        let favoriteCharacter = FavoriteCharacter(context: managedObjectContext)
        favoriteCharacter.name = character.name
        favoriteCharacter.status = character.status.rawValue
        favoriteCharacter.species = character.species.rawValue
        favoriteCharacter.image = character.image
        favoriteCharacter.gender = character.gender.rawValue
        favoriteCharacter.type = character.type
        favoriteCharacter.origin = character.origin.name
        favoriteCharacter.location = character.location.name
        
        do {
            try managedObjectContext.save()
        } catch {
            // Handle save error
        }
    }
}
