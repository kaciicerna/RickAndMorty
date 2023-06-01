//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 28.05.2023.
//

import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchText: String = ""
    @Published var isShowingDetails: Bool = false
    @Published var selectedCharacter: Character? = nil
    
    private var page: Int = 1
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(page)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(CharactersResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: decodedResponse.results)
                    self.page += 1
                }
            }
        }.resume()
    }
    
    func selectCharacter(_ character: Character) {
        selectedCharacter = character
        isShowingDetails = true
    }
    
    func closeDetails() {
        selectedCharacter = nil
        isShowingDetails = false
    }
}
