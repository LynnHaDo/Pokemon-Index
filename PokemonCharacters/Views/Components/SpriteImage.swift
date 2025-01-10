//
//  SpriteImage.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import SwiftUI

struct SpriteImage: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            Image(.defaultSprite)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
        }
    }
}
