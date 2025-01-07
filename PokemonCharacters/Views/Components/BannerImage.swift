//
//  BannerImage.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct BannerImage: View {
    let image: Image
    
    var body: some View {
        image.resizable()
             .scaledToFit()
             .overlay {
                LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.6),
                                       Gradient.Stop(color: .background, location: 1)],
                startPoint: .top, endPoint: .bottom)
             }
    }
}
