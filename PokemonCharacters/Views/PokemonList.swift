//
//  PokemonList.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

struct PokemonList: View {
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
                    if let pokemonsList = pokemonsList
                    {
                        CustomNavigationStack(navigationTitle: "PokéIndex", isNotHome: false) {
                            ScrollView {
                                ZStack {
                                    Color.background.ignoresSafeArea()

                                    VStack(alignment: .leading) {
                                        BannerImage(image: Image(.banner)).scaleEffect(2)
                                        
                                        Text("Welcome to Pokémon World").title()
                                        
                                        LazyVStack {
                                            ForEach(0..<pokemonsList.count, id: \.self) { idx in
                                                NavigationLink(destination: PokemonDetails(resourceUrl: pokemonsList[idx].url)) {
                                                    ItemView(name: pokemonsList[idx].name)
                                                }
                                            }
                                        }
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
    PokemonList()
}
