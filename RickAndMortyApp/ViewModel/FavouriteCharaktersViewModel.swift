//
//  FavouriteCharaktersViewModel.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//
import SwiftUI

class FavoriteCharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func addCharacterToFavorites(_ character: Character) {
        characters.append(character)
    }
    
    func removeCharacterFromFavorites(_ character: Character) {
        if let index = characters.firstIndex(where: { $0.name == character.name }) {
            characters.remove(at: index)
        }
    }
}
