//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Kateřina Černá on 26.05.2023.
//

import SwiftUI
@main
struct RickAndMortyAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var favoritesManager = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                TabView {
                    CharactersListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(favoritesManager)
                        .tabItem {
                            Image("hIcon")
                        }
                    
                    FavoritesListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(favoritesManager)
                        .tabItem {
                            Image("sIcon")
                        }
                }
                
                VStack {
                    Spacer()
                    GeometryReader { geometry in
                        Color.clear
                            .frame(height: 182)
                            .frame(width: geometry.size.width - 62)
                            .cornerRadius(31)
                            .shadow(radius: 5)
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
}
