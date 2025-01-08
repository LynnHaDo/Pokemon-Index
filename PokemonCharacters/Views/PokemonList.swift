//
//  PokemonList.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

struct PokemonList: View {
    let list: [PokemonName]
    
    func getImageUrlFrom(_ url: String) -> String
    {
        guard let id = Int(url.components(separatedBy: Routes.baseUrl)[1].dropLast()) else { return "" }
        return Routes.pokemonImageUrl(id)
    }
    
    var body: some View {
        if list.count == 0 {
            VStack {
                Text("No Pokémons found. Please try again.")
                    .heading()
                    .padding(.top, 15)
            }
        }
        else {
            LazyVStack {
                ForEach(0..<list.count, id: \.self) { idx in
                    let pokemon = list[idx]
                    NavigationLink(destination: PokemonDetails(resourceUrl: pokemon.url)) {
                        ItemView(name: pokemon.name,
                                 spriteImage: SpriteImage(url: getImageUrlFrom(pokemon.url)))
                        
                    }
                }
            }
        }
    }
}
