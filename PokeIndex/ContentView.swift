//
//  ContentView.swift
//  PokeIndex
//
//  Created by Do Linh on 1/15/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokemons: FetchedResults<Pokemon>

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemons) { pokemon in
                    NavigationLink {
                        Text("Pokemon \(pokemon.name!)")
                        AsyncImage(url: pokemon.sprite)
                        AsyncImage(url: pokemon.shiny)
                    } label: {
                        Text(pokemon.name!)
                    }
                }
            }
            .toolbar {
                
            }
            Text("Select an item")
        }
    }

    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
