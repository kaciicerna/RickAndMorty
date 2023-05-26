//
//  SearchBarView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search character", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(4)
                }
            }
        }
        .background(Color.clear)
    }
}
