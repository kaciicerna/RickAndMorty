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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorites) { favorite in
                    NavigationLink(destination: CharacterDetailView(name: favorite.name ?? "",
                                                                    status: favorite.status ?? "",
                                                                    species: favorite.species ?? "",
                                                                    type: "",
                                                                    gender: "",
                                                                    origin: "",
                                                                    location: "",
                                                                    imageURL: "")) {
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            .navigationBarTitle("Favorites")
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

struct FavouriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
