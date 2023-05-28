//
//  FavouritesView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 28.05.2023.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FavoriteCharacterViewModel.entity(),
        sortDescriptors: [],
        animation: .default
    ) private var favorites: FetchedResults<FavoriteCharacterViewModel>
    
    var body: some View {
        List(favorites, id: \.self) { favorite in
            Text(favorite.name)
            // Display other properties of favoriteCharacter
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
