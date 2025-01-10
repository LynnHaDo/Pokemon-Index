//
//  ContentView.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var wrapper: PokemonWrapper = pokemonWrapper

    @State var searchText: String = ""
    @State var isSorting: Bool = false
    @State var isSortAscending: Bool = false
    
    @State var isDataLoading: Bool = true
    
    var pokeList: [PokemonName] {
        var l = FilterService
            .search(searchText, from: wrapper.allPokemons, prop: \.name)
        
        if (isSorting) {
            l = FilterService.sort(from: l, prop: \.name, ascending: isSortAscending)
        }
        
        return l
    }
    
    var suggestions: [String] {
        guard !searchText.isEmpty else { return [] }
        return Array(wrapper.allNames.sorted().filter { $0.lowercased().localizedStandardContains(searchText) }.prefix(10))
    }
    
    var body: some View {
        Loader(isShown: $isDataLoading) {
            ZStack {
                Color.background.ignoresSafeArea()
                
                CustomNavigationStack(navigationTitle: "PokéIndex", isNotHome: false) {
                    ScrollView {
                        ZStack {
                            Color.background.ignoresSafeArea()

                            VStack(alignment: .leading) {
                                // Banner image
                                BannerImage(image: Image(.banner)).scaleEffect(2)
                                
                                // Banner text
                                Text("Welcome to Pokémon World").title()
                                
                                HStack {
                                    Text("\(wrapper.numPokemons) pokémons").regular()
                                    Spacer()
                                    Button {
                                        isSorting = true
                                        isSortAscending.toggle()
                                    } label: {
                                        Text("Sort name").regular()
                                        Image(systemName: isSortAscending ? "arrowtriangle.up.square" : "arrowtriangle.down.square").foregroundStyle(Color.text)
                                    }
                                    .padding(.vertical, 5)
                                }
                                
                                // List of pokemons
                                PokemonList(list: pokeList)
                            }
                            .padding(.vertical, 30)
                            .padding(.horizontal)
                        }
                    }
                }
                .searchable(text: $searchText)
                .searchSuggestions {
                    SearchSuggestionsView(suggestions: suggestions, keyword: $searchText)
                }
                .autocorrectionDisabled()
                .animation(.default, value: searchText)
            }
            .onAppear() {
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .text
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isDataLoading = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


