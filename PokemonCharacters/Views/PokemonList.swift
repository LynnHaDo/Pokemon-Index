//
//  PokemonList.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI
import MapKit

struct PokemonList: View {
    let list: [PokemonName]
    
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
                    let location = pokemon.location
                    NavigationLink(destination: PokemonDetails(resourceUrl: pokemon.url,
                                                               location: location,
                                                               locationMap: .camera(MapCamera(centerCoordinate: location.1, distance: 10000)))) {
                        ItemView(name: pokemon.name,
                                 spriteImage: SpriteImage(url: pokemon.imageUrl))
                        
                    }
                }
            }
        }
    }
}
