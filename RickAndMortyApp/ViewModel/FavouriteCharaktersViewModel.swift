//
//  FavouriteCharaktersViewModel.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//
import CoreData
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favorites: [Character] = []
    
    func addFavorite(_ character: Character) {
        favorites.append(character)
    }
    
    func removeFavorite(_ character: Character) {
        if let index = favorites.firstIndex(where: { $0.name == character.name }) {
            favorites.remove(at: index)
        }
    }
    
    func isFavorite(_ character: Character) -> Bool {
        return favorites.contains { $0.name == character.name }
    }
}


