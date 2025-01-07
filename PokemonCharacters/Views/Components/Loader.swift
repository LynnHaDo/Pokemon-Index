//
//  Loader.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

// Reference: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
struct Loader<Content: View>: View {
    @Binding var isShown: Bool
    
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content
                    .disabled(self.isShown)
                    .blur(radius: self.isShown ? 3 : 0)
                
                VStack {
                    Color.clear
                    HStack {
                        Spacer()
                        VStack {
                            GIFImageView("loader")
                                .blendMode(.darken)
                        }
                        .frame(width: geometry.size.width / 2,
                               height: geometry.size.height / 5)
                        .background(Color.accent)
                        .foregroundStyle(Color.background)
                        .opacity(self.isShown ? 1 : 0)
                        .cornerRadius(5)
                        Spacer()
                    }
                    Color.clear
                }
            }
        }
    }
}
