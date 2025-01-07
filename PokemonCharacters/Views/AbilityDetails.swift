//
//  AbilityDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct AbilityView: View {
    let abilityName: String
    let pokemonName: String 
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
            }
        }
        self.isDataLoading = false
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                if (errorMessage != "")
                {
                    Text(errorMessage).regular()
                }
                else {
                    if let ability = ability {
                        CustomNavigationStack(navigationTitle: abilityName,
                                              navigationSubheading: "\(pokemonName) abilities") {
                            ScrollView {
                                VStack {
                                    HStack {
                                        Text(abilityName.capitalized).title()
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        ForEach(0..<ability.effectEntries.count, id: \.self) { idx in
                                            EffectEntryView(entry: ability.effectEntries[idx])
                                        }
                                    }
                                    
                                    HStack {
                                        Heading(name: "Related Pokémons",
                                                description: "A list of Pokémon that could potentially have this ability.")
                                        Spacer()
                                    }
                                    
                                    LazyVStack {
                                        ForEach(0..<ability.pokemon.count, id: \.self) {
                                            idx in
                                            let pokemonAbility: PokemonAbility.PokemonEffectEntry = ability.pokemon[idx]
                                            NavigationLink(destination: PokemonDetails(resourceUrl: pokemonAbility.pokemon.url)) {
                                                ItemView(name: pokemonAbility.pokemon.name,
                                                         tag: Tag(content: pokemonAbility.isHidden ? "Hidden" : "Not hidden",
                                                                  type: pokemonAbility.isHidden ? TagType.pink : TagType.green))
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 30)
                                .padding(.horizontal)
                            }
                        }
                    }
                    else {
                        Text("Ability info is not available.").regular()
                    }
                }
            }
        }
        .onAppear() {
            getAbility()
        }
    }
}

struct EffectEntryView: View {
    let entry: PokemonAbility.Entry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Tag(content: entry.language.name, type: .green)
                    Spacer()
                }
                
                Text(entry.shortEffect).subheading()
                    .frame(alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 10)
                
                Text(entry.effect).regular()
                    .frame(alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top, 15)
    }
}

#Preview {
    AbilityView(abilityName: "overgrow", pokemonName: "venusaur", resourceUrl: "https://pokeapi.co/api/v2/ability/5/")
}
