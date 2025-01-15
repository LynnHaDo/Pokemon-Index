//
//  PokeIndexApp.swift
//  PokeIndex
//
//  Created by Do Linh on 1/15/25.
//

import SwiftUI

@main
struct PokeIndexApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
