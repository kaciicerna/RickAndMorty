//
//  FavouriteListView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
import CoreData

struct FavoritesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavoriteCharacter.entity(), sortDescriptors: []) var favorites: FetchedResults<FavoriteCharacter>
    @EnvironmentObject private var favoritesManager: FavoritesManager
    @StateObject private var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            if favorites.isEmpty {
                Text("No favorites yet")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitle("Favorites")
            } else {
                List {
                    ForEach(favorites) { favorite in
                        NavigationLink(destination: CharacterDetailView(
                            name: favorite.name ?? "",
                            status: favorite.status ?? "",
                            species: favorite.species ?? "",
                            type: favorite.type ?? "",
                            gender: favorite.gender ?? "",
                            origin: favorite.origin ?? "",
                            location: favorite.location ?? "",
                            imageURL: favorite.image ?? "",
                            viewModel: DetailCharacterViewModel(
                                character: nil,
                                favoritesManager: favoritesManager,
                                managedObjectContext: viewContext
                            )
                        )) {
                            RowListView(
                                name: favorite.name ?? "",
                                status: favorite.status ?? "",
                                species: favorite.species ?? "",
                                type: favorite.type ?? "",
                                gender: favorite.gender ?? "",
                                origin: favorite.origin ?? "",
                                location: favorite.location ?? "",
                                imageURL: favorite.image ?? ""
                            )
                        }
                        .isDetailLink(false) 
                    }
                    .onDelete(perform: deleteFavorites)
                }
                .navigationBarTitle("Favorites")
                .onAppear(perform: viewModel.fetchCharacters)
            }
        }
    }
    
    private func deleteFavorites(at offsets: IndexSet) {
        offsets.forEach { index in
            let favorite = favorites[index]
            viewContext.delete(favorite)
            
            do {
                try viewContext.save()
            } catch {
                // Handle save error
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}

