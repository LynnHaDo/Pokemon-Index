//
//  PokemonMap.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import SwiftUI
import MapKit

struct PokemonMap: View {
    @EnvironmentObject var wrapper: PokemonWrapper
    
    @State var position: MapCameraPosition
    @State var satellite: Bool = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(0..<wrapper.allPokemons.count, id: \.self) { idx in
                let pokemon = wrapper.allPokemons[idx]
                Annotation(pokemon.name, coordinate: pokemon.location.1)
                {
                    SpriteImage(url: pokemon.imageUrl)
                        .shadow(color: .text, radius: 3)
                        .scaleEffect(7)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .shadow(radius: 3)
                    .padding(20)
            }
        }
    }
}

#Preview {
    PokemonMap(position: .camera(
        MapCamera(
            centerCoordinate: locationService.getRandomPosition("Venusaur").1,
            distance: 2000,
            heading: 230,
            pitch: 80
        )
    )).environmentObject(pokemonWrapper)
}
