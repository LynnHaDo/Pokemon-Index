//
//  Heading.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct Heading: View {
    let name: String
    let description: String
    var value: StringOrInt?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(name).heading()
                Text(description).caption().padding([.top, .bottom], 2)
            }
            
            Spacer()
            if let value {
                Text(value.intVal == nil ? value.strVal! : String(value.intVal!)).regular()
            }
        }
        .padding([.top, .bottom], 10)
    }
}
