//
//  ContentView.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct ContentView: View {

    @State var searchText: String = ""
    @State var isSorting: Bool = false
    @State var isSortAscending: Bool = false
    
    @State var allNames: [String] = []
    @State var allPokemons: [PokemonName]?
    
    @State var isDataLoading: Bool = true
    @State var errorMessage: String = ""
    
    @State var previousTask: URLSessionTask?
    
    var pokeList: [PokemonName] {
        var l = FilterService
            .search(searchText, from: allPokemons, prop: \.name)
        
        if (isSorting) {
            l = FilterService.sort(from: l, prop: \.name, ascending: isSortAscending)
        }
        
        return l
    }
    
    var suggestions: [String] {
        guard !searchText.isEmpty else { return [] }
        return Array(allNames.sorted().filter { $0.lowercased().localizedStandardContains(searchText) }.prefix(10))
    }
    
    func getData() {
        let url = Routes.baseUrl
        
        previousTask?.cancel()
        
        previousTask = APIService.get(url) { (response: Pokemons?, error: Error?) in
            if let error = error {
                errorMessage = error.localizedDescription
            }
            
            if let response = response {
                allPokemons = response.results
                allNames = response.results.map { $0.name.capitalizeFirst() }
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
                                    
                                    HStack {
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
            }
            .onAppear() {
                getData()
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .text
                
            }
        }
    }
}

#Preview {
    ContentView()
}


