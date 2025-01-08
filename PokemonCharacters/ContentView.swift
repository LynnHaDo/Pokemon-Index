//
//  ContentView.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct ContentView: View {

    @State var searchText: String = ""
    @State var allPokemons: [PokemonName]?
    //@State var sortProperty: KeyPath<Pokemon, any Comparable>
    
    
    
    @State var isDataLoading: Bool = true
    @State var errorMessage: String = ""
    
    @State var previousTask: URLSessionTask?
    
    var pokeList: [PokemonName]? { FilterService.filterByKeyword(searchText, from: allPokemons, prop: \.name)
    }
    
    func getPokemons() {
        let url = Routes.baseUrl
        
        previousTask?.cancel()
        
        previousTask = APIService.get(url) { (response: Pokemons?, error: Error?) in
            if let error = error {
                errorMessage = error.localizedDescription
            }
            
            if let response = response {
                allPokemons = response.results
            }
        }
        
        isDataLoading = false
    }
    
    var body: some View {
        Loader(isShown: $isDataLoading) {
            ZStack {
                Color.background.ignoresSafeArea()
                
                if (self.errorMessage != "") {
                    Text(self.errorMessage)
                }
                else {
                    CustomNavigationStack(navigationTitle: "PokéIndex", isNotHome: false) {
                        ScrollView {
                            ZStack {
                                Color.background.ignoresSafeArea()

                                VStack(alignment: .leading) {
                                    // Banner image
                                    BannerImage(image: Image(.banner)).scaleEffect(2)
                                    
                                    // Banner text
                                    Text("Welcome to Pokémon World").title()
                                    
                                    //Picker("Sort by", selection: $sortProperty) {
                                        //ForEach()
                                    //}

                                    // List of pokemons
                                    if let pokeList {
                                        PokemonList(list: pokeList)
                                    }
                                }
                                .padding(.vertical, 30)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    .autocorrectionDisabled()
                    .animation(.default, value: searchText)
                }
            }
            .onAppear() {
                getPokemons()
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .text
            }
        }
    }
}

#Preview {
    ContentView()
}
