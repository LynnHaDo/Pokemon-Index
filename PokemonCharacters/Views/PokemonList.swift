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
                    if (self.pokemonsList == nil)
                    {
                        Text("Error")
                    }
                    else {
                        NavigationStack {
                            ZStack {
                                Color.background.ignoresSafeArea()
                                
                                ScrollView {
                                    LazyVStack {
                                        ForEach(0..<self.pokemonsList!.count, id: \.self) { idx in
                                            NavigationLink(destination: PokemonDetails(resourceUrl: pokemonsList![idx].url)) {
                                                PokemonItemView(name: pokemonsList![idx].name)
                                            }
                                        }
                                    }
                                }
                                .list()
                            }
                        }
                        .navigationTitle("Pokemon Index")
                    }
                }
            }
            .onAppear() {
                getPokemons()
            }
        }
    }
}

struct PokemonItemView: View {
    let name: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(name.capitalized).heading().frame(width: geometry.size.width * 0.6, alignment: .leading)
                Spacer().frame(width: geometry.size.width * 0.3)
                Image(systemName: "arrow.right").frame(width: geometry.size.width * 0.1, alignment: .trailing).foregroundStyle(Color.text)
            }
        }
        .padding([.top, .bottom], 20)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundStyle(Color.gray),
                 alignment: .bottom)
    }
}

#Preview {
    PokemonList()
}
