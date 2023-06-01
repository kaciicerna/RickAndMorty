//
//  CustomTabBarView.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 31.05.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            TabBarItem(iconName: "hIcon")
            
            Spacer()
            
            TabBarItem(iconName: "sIcon")
            
            Spacer()
        }
        .frame(height: 62)
        .background(Color.white)
    }
}

struct TabBarItem: View {
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 28))
            .frame(width: 60, height: 60)
    }
}

