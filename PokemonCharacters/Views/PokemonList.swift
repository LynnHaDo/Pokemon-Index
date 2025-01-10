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
    @EnvironmentObject var wrapper: PokemonWrapper
    
    @State var isDataLoaded: Bool = false
    
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
                            
                            if idx == list.count - 1, isDataLoaded == false, let next = wrapper.nextUrl {
                                Button {
                                    wrapper.fetchData(next)
                                    isDataLoaded = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation(.smooth) {
                                            isDataLoaded = false
                                        }
                                    }
                                } label: {
                                    Text("Load more pokemons...").regular()
                                }
                                .padding(.vertical, 10)
                                .opacity(0.6)
                                .clipShape(.rect(cornerRadius: 5))
                                
                            }
                        }
                    }
                }
        
            
    }
}
