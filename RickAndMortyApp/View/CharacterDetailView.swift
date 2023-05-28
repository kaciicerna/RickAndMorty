//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
import URLImage
import CoreData


struct CharacterDetailView: View {
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: String
    var location: String
    var imageURL: String
    
    var character: Character?
    @EnvironmentObject private var favoritesManager: FavoritesManager
    
    var isFavorite: Bool {
        return favoritesManager.isFavorite(character!)
    }
    
    private func toggleFavorite() {
        if isFavorite {
            favoritesManager.removeFavorite(character!)
        } else {
            favoritesManager.addFavorite(character!)
        }
    }
    
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                URLImage(url: URL(string: imageURL)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 79) {
                        Text("Name")
                            .font(.headline)
                        
                        Button(action: {
                            if let character = character {
                                toggleFavorite()
                            }
                        }) {
                            Image(systemName: character != nil && favoritesManager.isFavorite(character!) ? "star.fill" : "star")
                                .foregroundColor(character != nil && favoritesManager.isFavorite(character!) ? .blue : .gray)
                                .frame(width: 30, height: 30)
                        }

                    }
                    
                    Text(name)
                        .font(.title2)
                        .bold()
                }
            }
            
            Divider()
                .padding(.top, 16)
                .padding(.bottom, 23)
            
            HStack(spacing: 53) {
                VStack(alignment: .leading, spacing: 27) {
                    Text("Species")
                    Text("Status")
                    Text("Type")
                    Text("Gender")
                    Text("Origin")
                    Text("Location")
                }
                VStack(alignment: .leading, spacing: 26) {
                    Text(species)
                    Text(status)
                    Text(type)
                    Text(gender)
                    Text(origin)
                    Text(location)
                }.bold()
            }
            .font(.title3)
        }
        .padding()
        .navigationBarItems(leading: backButton, trailing: characterName)
        .background(Color.clear)
    }
    
    private var backButton: some View {
        Button(action: {
        }) {
            Image(systemName: "chevron.left")
        }
    }
    
    private var characterName: some View {
        Text(name)
            .font(.headline)
    }
}
