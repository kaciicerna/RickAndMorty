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
    
    init(name: String, status: String, species: String, type: String, gender: String, origin: String, location: String, imageURL: String, viewModel: DetailCharacterViewModel) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.imageURL = imageURL
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @EnvironmentObject private var favoritesManager: FavoritesManager
    @StateObject private var viewModel: DetailCharacterViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 16) {
                    if let url = URL(string: imageURL) {
                        URLImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140, height: 140)
                                .cornerRadius(8)
                        }
                    } else {
                        // Handle the case where imageURL is nil
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 79) {
                            Text("Name")
                                .font(.headline)
                            
                            Button(action: {
                                viewModel.toggleFavorite()
                            }) {
                                Image(viewModel.isFavorite ? "starIconFull" : "starIcon")
                                    .foregroundColor(viewModel.isFavorite ? .purple : .gray)
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
            .background(.white)

                Spacer()
                
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                characterName
            }
        }
        .background(Color.clear)
    }
    
    private var characterName: some View {
        Text(name)
            .font(.title3)
    }
}
