//
//  PokemonDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 12/27/24.
//

import SwiftUI
import PokemonAPI

struct PokemonDetails: View {
    let id: Int
    
    @State var name: String = ""
    @State var error: String = ""
    
    func getPokemon() {
        PokemonAPI().pokemonService.fetchPokemon(self.id) {
            result in
            
            switch result {
                case .success(let pokemon):
                    self.name = pokemon.name!
                case .failure(let error):
                    self.error = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Details").title()
            
            Text(name).heading()
            
            Text(error).caption()
        }
        .onAppear() {
            getPokemon()
        }
    }
}
