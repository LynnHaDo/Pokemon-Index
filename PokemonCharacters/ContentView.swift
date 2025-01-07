//
//  ContentView.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var pokemonsList: [PokemonName]?
    
    @State var isDataLoading: Bool = true
    @State var errorMessage: String = ""
    
    func getPokemons() {
        let url = Routes.baseUrl
        
        APIService.get(url) { (response: Pokemons?, error: Error?) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
            
            if let response = response {
                self.pokemonsList = response.results
            }
        }
        
        self.isDataLoading = false
    }
    
    var body: some View {
        Loader(isShown: $isDataLoading) {
            ZStack {
                Color.background.ignoresSafeArea()
                
                if (self.errorMessage != "") {
                    Text(self.errorMessage)
                }
                else {
                    if let pokemonsList
                    {
                        CustomNavigationStack(navigationTitle: "PokéIndex", isNotHome: false) {
                            ScrollView {
                                ZStack {
                                    Color.background.ignoresSafeArea()

                                    VStack(alignment: .leading) {
                                        // Banner image
                                        BannerImage(image: Image(.banner)).scaleEffect(2)
                                        
                                        // Banner text
                                        Text("Welcome to Pokémon World").title()
                                        
                                        // List of pokemons
                                        PokemonList(list: pokemonsList)
                                    }
                                    .padding(.vertical, 30)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    else {
                        Text("Error")
                    }
                }
            }
            .onAppear() {
                getPokemons()
            }
        }
    }
}

#Preview {
    ContentView()
}
