//
//  PokemonDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 12/27/24.
//

import SwiftUI
import MapKit

struct PokemonDetails: View {
    let resourceUrl: String
    let location: (String, CLLocationCoordinate2D)
    @State var locationMap: MapCameraPosition
    @Namespace var namespace
    
    @State var sprite: Pokemon?
    @State var errorMessage: String = ""
    @State var isDataLoading: Bool = true
    @State var previousTask: URLSessionTask?
    
    func getPokemon() {
        previousTask?.cancel()
        
        previousTask = APIService.get(resourceUrl) { (response: Pokemon?, error: Error?) in
            if let error = error {
                errorMessage = error.localizedDescription
            }
            
            if let response = response {
                sprite = response
            }
        }
        self.isDataLoading = false
    }
    
    var body: some View {
        Loader(isShown: $isDataLoading) {
            ZStack {
                Color.background.ignoresSafeArea()
                
                if (self.errorMessage != "")
                {
                    Text(errorMessage).caption()
                }
                else {
                    if let sprite = sprite {
                        CustomNavigationStack(navigationTitle: sprite.name) {
                            GeometryReader { geo in
                                ScrollView {
                                    ZStack(alignment: .bottomTrailing) {
                                        // Background image
                                        BannerImage(image: sprite.backgroundImage())
                                        
                                        // Sprite image
                                        SpriteImage(url: sprite.imageUrl())
                                        .frame(width: geo.size.width * 0.5)
                                        .clipShape(.rect(cornerRadius: 5))
                                        .shadow(color: Color.background, radius: 7)
                                        .offset(y: geo.size.height * 0.1)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        // Sprite name
                                        Text(sprite.name.capitalized).title()
                                        
                                        Text("\(sprite.name.capitalized) is at \(location.0)").regular()
                                            .padding(.vertical, 5)
                                        
                                        // Current location
                                        NavigationLink(destination: PokemonMap(position: .camera(
                                                MapCamera(
                                                    centerCoordinate: location.1,
                                                    distance: 2000,
                                                    heading: 230,
                                                    pitch: 80
                                                )
                                            )
                                            )
                                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                                        ) {
                                            Map(position: $locationMap) {
                                                Annotation(sprite.name, coordinate: location.1)
                                                {
                                                    Image(systemName: "mappin.and.ellipse")
                                                        .font(.largeTitle)
                                                        .foregroundStyle(Color.accentColor)
                                                        .imageScale(.large)
                                                        .symbolEffect(PulseSymbolEffect.pulse)
                                                }
                                            }
                                            .frame(height: 200)
                                            .clipShape(.rect(cornerRadius: 5))
                                            .overlay(alignment: .trailing) {
                                                Image(systemName: "arrowtriangle.forward.square")
                                                    .imageScale(.large)
                                                    .font(.title3)
                                                    .foregroundStyle(Color.accentColor)
                                                    .padding(.trailing, 5)
                                            }
                                        }
                                        .matchedTransitionSource(id: 1, in: namespace)
                                        
                                        
                                        // Height
                                        Heading(name: "Height",
                                                description: "The height of this Pokémon in decimetres.",
                                                value: StringOrInt(strVal: nil, intVal: sprite.height))
                                        
                                        // Weight
                                        Heading(name: "Weight",
                                                description: "The weight of this Pokémon in hectograms.",
                                                value: StringOrInt(strVal: nil, intVal: sprite.weight))
                                        
                                        // Base experience
                                        Heading(name: "Base experience",
                                                description: "The base experience gained for defeating this Pokémon.",
                                                value: StringOrInt(strVal: nil, intVal: sprite.baseExperience))
                                        
                                        // Abilities
                                        Heading(name: "Abilities",
                                                description: "Abilities provide passive effects for Pokémon in battle or in the overworld. Pokémon have multiple possible abilities but can have only one ability at a time.")
                                        
                                        ForEach(0..<sprite.abilities.count, id: \.self) { idx in
                                            let abilityWrapper: Pokemon.Ability = sprite.abilities[idx]
                                            
                                            NavigationLink(destination:
                                                            AbilityView(abilityName: abilityWrapper.ability.name,
                                                                        pokemonName: sprite.name,
                                                                        pokemonLocation: location,
                                                                        pokemonLocationMap: locationMap,
                                                                        resourceUrl: abilityWrapper.ability.url)) {
                                                ItemView(name: abilityWrapper.ability.name,
                                                         tag: Tag(content: abilityWrapper.isHidden ? "Hidden" : "Not hidden", type: abilityWrapper.isHidden ? TagType.pink : TagType.green)
                                                )
                                            }
                                        }
                                    }
                                    .padding(.vertical, 30)
                                    .padding(.horizontal)
                                    .frame(width: geo.size.width)
                                }
                            }
                        }
                    }
                    else
                    {
                        Text("Sprite cannot be loaded.").caption()
                    }
                }
            }
        }
        .onAppear() {
            getPokemon()
        }
    }
}

#Preview {
    let location = locationService.getRandomPosition("Venusaur")
    PokemonDetails(resourceUrl: "https://pokeapi.co/api/v2/pokemon/3",
                   location: location,
                   locationMap: .camera(MapCamera(centerCoordinate: location.1, distance: 10000)))
}
