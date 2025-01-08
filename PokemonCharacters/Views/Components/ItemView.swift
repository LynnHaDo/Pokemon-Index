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
    var spriteImage: SpriteImage?
    var isLink: Bool = true
    
    @State private var totalHeight = CGFloat(70)
    
    var body: some View {
        
            GeometryReader { geometry in
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(name.capitalized).subheading().frame(width: geometry.size.width * 0.4, alignment: .leading)
                        tag
                    }
                    .frame(width: geometry.size.width * 0.4)
                    .padding(.vertical, 10)
                    .background(GeometryReader {gp -> Color in
                        DispatchQueue.main.async {
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
                    
                    if let spriteImage {
                        Spacer().frame(width: geometry.size.width * 0.05)
                        spriteImage.frame(width: geometry.size.width * 0.4)
                        Spacer().frame(width: geometry.size.width * 0.05)
                    }
                    else {
                        Spacer().frame(width: geometry.size.width * 0.5).border(.green)
                    }
                    
                    if isLink {
                        Image(systemName: "arrow.right")
                            .frame(width: geometry.size.width * 0.1, alignment: .trailing)
                            .foregroundStyle(Color.text)
                    }
                }
            }
            .frame(height: totalHeight)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundStyle(Color.gray),
                         alignment: .bottom)
    }
}
