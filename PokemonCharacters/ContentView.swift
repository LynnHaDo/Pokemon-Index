//
//  ContentView.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            Text("Pokémon Characters").title()
        }
    }
}

#Preview {
    ContentView()
}
