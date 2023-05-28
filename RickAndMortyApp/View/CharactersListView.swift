//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
import URLImage

struct CharactersListView: View {
    @State private var characters: [Character] = []
    @State private var page: Int = 1
    @State private var selectedCharacter: Character? = nil
    @State private var isShowingDetails: Bool = false
    @State private var searchText: String = ""
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText)
                    .padding()
                
                List(filteredCharacters, id: \.id) { character in
                    HStack {
                        URLImage(url: URL(string: character.image)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.headline)
                            
                            Text(character.status.rawValue)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            selectedCharacter = character
                            isShowingDetails = true
                        }){
                            Image("arrow")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationBarTitle("Characters")
                .onAppear(perform: fetchCharacters)
                .sheet(isPresented: $isShowingDetails) {
                    if let character = selectedCharacter {
                        CharacterDetailView(
                            name: character.name,
                            status: character.status.rawValue,
                            species: character.species.rawValue,
                            type: character.type,
                            gender: character.gender.rawValue,
                            origin: character.origin.name,
                            location: character.location.name,
                            imageURL: character.image
                        )
                    }
                }
            }
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
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
