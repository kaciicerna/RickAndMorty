//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
import URLImage
import CoreData

struct CharactersListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    @StateObject private var favoritesManager = FavoritesManager()
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(text: $viewModel.searchText)
                    .padding()
                    .background(Color.clear)

                List(viewModel.filteredCharacters, id: \.id) { character in
                    NavigationLink(destination: CharacterDetailView(
                        name: character.name,
                        status: character.status.rawValue,
                        species: character.species.rawValue,
                        type: character.type,
                        gender: character.gender.rawValue,
                        origin: character.origin.name,
                        location: character.location.name,
                        imageURL: character.image,
                        viewModel: DetailCharacterViewModel(
                            character: character,
                            favoritesManager: favoritesManager,
                            managedObjectContext: viewContext
                        )
                    )) {
                        RowListView(
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
                .navigationBarTitle("Characters")
                .onAppear(perform: viewModel.fetchCharacters)
            }
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
