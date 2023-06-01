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
    @State private var isHIconSelected = false
    @State private var isSIconSelected = false

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                TabView(selection: tabSelectionBinding) {
                    CharactersListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(favoritesManager)
                        .tabItem {
                            Image(isHIconSelected ? "hIconP" : "hIcon")
                        }
                        .tag(0)

                    FavoritesListView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(favoritesManager)
                        .tabItem {
                            Image(isSIconSelected ? "sIconP" : "sIcon")
                        }
                        .tag(1)
                }
                .background(.clear)
            }
            .onAppear {
                isHIconSelected = true
            }
        }
    }

    var tabSelectionBinding: Binding<Int> {
        Binding<Int>(
            get: {
                isHIconSelected ? 0 : 1
            },
            set: { newValue in
                isHIconSelected = newValue == 0
                isSIconSelected = newValue == 1
            }
        )
    }
}

