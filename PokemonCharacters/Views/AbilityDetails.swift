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
                        CustomNavigationStack(navigationTitle: abilityName, navigationSubheading: "\(pokemonName) abilities") {
                            VStack {
                                ForEach(0..<ability.effectEntries.count, id: \.self) { idx in
                                    
                                }
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



#Preview {
    AbilityView(abilityName: "overgrow", pokemonName: "venusaur", resourceUrl: "https://pokeapi.co/api/v2/ability/65/")
}
