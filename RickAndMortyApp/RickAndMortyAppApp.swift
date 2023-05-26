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

    var body: some Scene {
        WindowGroup {
            CharactersListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
