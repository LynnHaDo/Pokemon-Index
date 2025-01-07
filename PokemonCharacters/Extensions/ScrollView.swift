//
//  ScrollView.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

extension ScrollView {
    func list() -> some View {
        self.contentMargins(.horizontal, 30)
            .scrollBounceBehavior(.always)
            .scrollTargetBehavior(.viewAligned) // paging behaviour
    }
}
