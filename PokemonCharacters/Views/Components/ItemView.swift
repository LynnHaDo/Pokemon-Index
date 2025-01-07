//
//  PokemonItemView.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct ItemView: View {
    let name: String
    var tag: Tag?
    var isLink: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(name.capitalized).subheading().frame(width: geometry.size.width * 0.4, alignment: .leading)
                
                if let tag {
                    Spacer().frame(width: geometry.size.width * 0.05)
                    tag.frame(width: geometry.size.width * 0.4)
                    Spacer().frame(width: geometry.size.width * 0.05)
                }
                else {
                    Spacer().frame(width: geometry.size.width * 0.5)
                }
                
                if isLink {
                    Image(systemName: "arrow.right").frame(width: geometry.size.width * 0.1, alignment: .trailing).foregroundStyle(Color.text)
                }
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 40)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundStyle(Color.gray),
                 alignment: .bottom)
    }
}
