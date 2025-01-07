//
//  PokemonList.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

struct PokemonList: View {
    let list: [PokemonName]
    
    var body: some View {
        LazyVStack {
            ForEach(0..<list.count, id: \.self) { idx in
                let pokemon = list[idx]
                NavigationLink(destination: PokemonDetails(resourceUrl: pokemon.url)) {
                    ItemView(name: pokemon.name)
                }
            }
        }
    }
}
