//
//  PokemonDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 12/27/24.
//

import SwiftUI

struct PokemonDetails: View {
    let resourceUrl: String
    
    @State var sprite: Pokemon?
    @State var errorMessage: String = ""
    @State var isDataLoading: Bool = true
    
    func getPokemon() {
        APIService.get(resourceUrl) { (response: Pokemon?, error: Error?) in
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
                                        AsyncImage(url: URL(string: sprite.imageUrl())) { image in
                                            image.resizable().scaledToFit()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: geo.size.width * 0.5)
                                        .clipShape(.rect(cornerRadius: 5))
                                        .shadow(color: Color.background, radius: 7)
                                        .offset(y: geo.size.height * 0.1)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        // Sprite name
                                        Text(sprite.name.capitalized).title()
                                        
                                        // Current location
                                        
                                        // Height
                                        Feature(name: "Height", description: "The height of this Pokémon in decimetres.", value: StringOrInt(strVal: nil, intVal: sprite.height))
                                        
                                        // Weight
                                        Feature(name: "Weight", description: "The weight of this Pokémon in hectograms.", value: StringOrInt(strVal: nil, intVal: sprite.weight))
                                        
                                        // Base experience
                                        Feature(name: "Base experience", description: "The base experience gained for defeating this Pokémon.", value: StringOrInt(strVal: nil, intVal: sprite.baseExperience))
                                        
                                        // Abilities
                                        Feature(name: "Abilities",
                                                description: "Abilities provide passive effects for Pokémon in battle or in the overworld. Pokémon have multiple possible abilities but can have only one ability at a time.")
                                        
                                        ForEach(0..<sprite.abilities.count, id: \.self) { idx in
                                            NavigationLink(destination: AbilityView(abilityName: sprite.abilities[idx].ability.name, pokemonName: sprite.name, resourceUrl: sprite.abilities[idx].ability.url)) {
                                                AbilityItemView(name: sprite.abilities[idx].ability.name, isHidden: sprite.abilities[idx].isHidden)
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

struct Feature: View {
    let name: String
    let description: String
    var value: StringOrInt?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(name).heading()
                Text(description).caption().padding([.top, .bottom], 2)
            }
            
            Spacer()
            if let value = value {
                Text(value.intVal == nil ? value.strVal! : String(value.intVal!)).regular()
            }
        }
        .padding([.top, .bottom], 10)
    }
}

struct AbilityItemView: View {
    let name: String
    let isHidden: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(name.capitalized).subheading().frame(width: geometry.size.width * 0.4, alignment: .leading)
                Spacer().frame(width: geometry.size.width * 0.05)
                Tag(content: isHidden ? "Hidden" : "Not hidden",
                    type: isHidden ? TagType.pink : TagType.green).frame(width: geometry.size.width * 0.4)
                Spacer().frame(width: geometry.size.width * 0.05)
                Image(systemName: "arrow.right").frame(width: geometry.size.width * 0.1, alignment: .trailing).foregroundStyle(Color.text)
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 40)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundStyle(Color.gray),
                 alignment: .bottom)
    }
}

#Preview {
    PokemonDetails(resourceUrl: "https://pokeapi.co/api/v2/pokemon/3/")
}
