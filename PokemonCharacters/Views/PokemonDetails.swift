//
//  PokemonDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 12/27/24.
//

import SwiftUI

struct PokemonDetails: View {
    let id: Int
    
    @State var name: String = ""
    @State var error: String = ""
    
    func getPokemon() {
        
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
