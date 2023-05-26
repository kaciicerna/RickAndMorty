//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
import URLImage

struct CharacterDetailView: View {
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: String
    var location: String
    var imageURL: String
    
    @State private var isFavorite: Bool = false
    @EnvironmentObject var favoriteCharactersVM: FavoriteCharactersViewModel
    
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
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                                .foregroundColor(isFavorite ? .yellow : .gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    Text(name)
                        .font(.title2)
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
            // Handle back button action
        }) {
            Image(systemName: "chevron.left")
        }
    }
    
    private var characterName: some View {
        Text(name)
            .font(.headline)
    }
}
