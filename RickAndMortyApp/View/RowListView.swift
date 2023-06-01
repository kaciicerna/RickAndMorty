//
//  RowListView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 31.05.2023.
//

import SwiftUI
import URLImage

struct RowListView: View {
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: String
    var location: String
    var imageURL: String
    //var isFavorite: Bool
    
    @EnvironmentObject private var favoritesManager: FavoritesManager

    
    var body: some View {
        VStack {
            HStack {
                if let url = URL(string: imageURL) {
                    URLImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .cornerRadius(10)
                    }
                } else {
                    // Handle the case where imageURL is nil
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text(name)
                            .font(.headline)
                        
                       /* if favoritesManager.isFavorite(isFavorite) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.purple)
                                .frame(width: 14, height: 14)
                        }*/
                    }
                    
                    Text(status)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()

            }
        }
    }
}

