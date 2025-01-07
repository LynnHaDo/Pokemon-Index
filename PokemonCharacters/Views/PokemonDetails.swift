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
            if (self.errorMessage != "")
            {
                ZStack {
                    Color.background.ignoresSafeArea()
                    Text(errorMessage).caption()
                }
            }
            else {
                if (self.sprite == nil) {
                    ZStack {
                        Color.background.ignoresSafeArea()
                        
                        Text("Sprite cannot be loaded.").caption()
                    }
                }
                else
                {
                    GeometryReader { geo in
                        ScrollView {
                            ZStack(alignment: .bottomTrailing) {
                                // Background image
                                sprite!.backgroundImage()
                                    .resizable()
                                    .scaledToFit()
                                
                                Color.black.frame(width: geo.size.width, height: 40).blur(radius: 20).offset(y: 20)
                                
                                // Sprite image
                                AsyncImage(url: URL(string: sprite!.imageUrl())) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: geo.size.width * 0.5)
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: Color.background, radius: 7)
                                .offset(y: 60)
                            }
                            
                            VStack(alignment: .leading) {
                                // Sprite name
                                Text(sprite!.name.capitalized).title()
                                
                                // Current location
                                
                                // Height
                                Feature(name: "Height", description: "The height of this Pokémon in decimetres.", value: StringOrInt(strVal: nil, intVal: sprite!.height))
                                
                                // Weight
                                Feature(name: "Weight", description: "The weight of this Pokémon in hectograms.", value: StringOrInt(strVal: nil, intVal: sprite!.weight))
                                
                                // Base experience
                                Feature(name: "Base experience", description: "The base experience gained for defeating this Pokémon.", value: StringOrInt(strVal: nil, intVal: sprite!.baseExperience))
                                
                                // Abilities
                                Text("Abilities").heading()
                                
                                ForEach(0..<sprite!.abilities.count, id: \.self) { idx in
                                    Text(sprite!.abilities[idx].ability.name).heading()
                                    Text("This is \(sprite!.abilities[idx].isHidden ? "" : "not") a hidden ability.").regular()
                                    AbilityView(resourceUrl: sprite!.abilities[idx].ability.url)
                                }
                            }
                            .padding([.top, .bottom], 30)
                            .padding([.leading, .trailing])
                            .frame(width: geo.size.width)
                            
                        }
                    }
                    .ignoresSafeArea()
                    .background(Color.background)
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
    let value: StringOrInt
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(name).heading()
                Text(description).caption().padding([.top, .bottom], 2)
            }
            
            Spacer()
            Text(value.intVal == nil ? value.strVal! : String(value.intVal!)).regular()
        }
        .padding([.top, .bottom], 10)
    }
}

struct AbilityView: View {
    let resourceUrl: String
    
    @State var ability: PokemonAbility?
    @State var errorMessage: String = ""
    @State var isDataLoading: Bool = true
    
    func getAbility() {
        APIService.get(resourceUrl) { (response: PokemonAbility?, error: Error?) in
            if let error = error {
                errorMessage = error.localizedDescription
            }
            
            if let response = response {
                ability = response
                print(response)
            }
        }
        self.isDataLoading = false
    }
    
    var body: some View {
        VStack {
            if (errorMessage != "")
            {
                Text(errorMessage).caption()
            }
            else {
                if (ability == nil) {
                    Text("Ability info is not available.")
                }
                else {
                    VStack {
                        ForEach(0..<ability!.effectEntries.count, id: \.self) { idx in
                            Feature(name: ability!.effectEntries[idx].shortEffect, description: ability!.effectEntries[idx].effect, value: StringOrInt(strVal: ability!.effectEntries[idx].language.name, intVal: nil))
                        }
                    }
                }
            }
        }
        .onAppear() {
            getAbility()
        }
    }
}

#Preview {
    PokemonDetails(resourceUrl: "https://pokeapi.co/api/v2/pokemon/3/")
}
