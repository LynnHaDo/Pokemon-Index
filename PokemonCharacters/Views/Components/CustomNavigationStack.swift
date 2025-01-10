//
//  CustomNavigationStack.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct CustomBackButton: View {
    let dismiss: DismissAction
    
    var body: some View {
        Button {
            dismiss()
        } label : {
            Image(systemName: "arrow.left")
        }
    }
}

struct CustomNavigationStack<Content: View>: View {
    let navigationTitle: String
    var isNotHome: Bool = true
    var navigationSubheading: String?
    
    @Environment(\.dismiss) var dismiss
    
    @ViewBuilder let content: Content
    
    var body: some View {
        NavigationStack {
            self.content
                .background(Color.background)
                .toolbarBackground(Color.background, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    if isNotHome {
                        ToolbarItem(placement: .topBarLeading) {
                            CustomBackButton(dismiss: self.dismiss)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text(navigationTitle.capitalizeFirst()).subheading()
                            
                            if let navigationSubheading = navigationSubheading {
                                Text(navigationSubheading.capitalizeFirst()).caption()
                            }
                        }
                    }
                }
        }
        .environmentObject(pokemonWrapper)
    }
}
