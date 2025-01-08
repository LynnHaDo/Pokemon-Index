//
//  SearchSuggestionsView.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import SwiftUI

struct SearchSuggestionsView: View {
    let suggestions: [String]
    @Binding var keyword: String
    
    var body: some View {
        ForEach(0..<suggestions.count, id: \.self) { idx in
            Button {
                keyword = suggestions[idx]
            } label: {
                HStack {
                    SpriteImage(url: Routes.pokemonImageUrl(idx)).frame(width: 20, height: 20)
                    Text(suggestions[idx]).caption()
                }
            }
        }
    }
}
