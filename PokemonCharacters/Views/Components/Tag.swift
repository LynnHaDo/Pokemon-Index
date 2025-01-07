//
//  Tag.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

enum TagType {
    case primary
    case success
    case danger
    case green
    case pink
    case mustard
    
    var background: Color {
        switch self {
            case .primary:
                    .accent
            case .success:
                    .success
            case .danger:
                    .danger
            case .green:
                    .lightGreen
            case .pink:
                    .hotPink
            case .mustard:
                    .mustard
        }
    }
}

struct Tag: View {
    let content: String
    let type: TagType
    
    var body: some View {
        Text(content).regular()
            .padding(.horizontal, 13)
            .padding(.vertical, 5)
            .background(type.background)
            .cornerRadius(15)
    }
}
