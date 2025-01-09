//
//  Pokemon.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI
import MapKit

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let abilities: [Ability]
    
    func imageUrl() -> String {
        return Routes.pokemonImageUrl(id)
    }
    
    func backgroundImage() -> Image {
        let type = self.name.count % 3
        
        switch type {
            case 0:
                return Image(.sceneOne)
            case 1:
                return Image(.sceneTwo)
            default:
                return Image(.sceneThree)
        }
    }
    
    struct Ability: Decodable {
        let ability: AbilityItem
        let isHidden: Bool 
        
        struct AbilityItem: Decodable {
            let name: String
            let url: String
        }
    }
}

struct PokemonAbility: Decodable {
    let effectEntries: [Entry]
    let pokemon: [PokemonEffectEntry]
    
    struct Entry: Decodable {
        let effect: String
        let language: LanguageEntry
        let shortEffect: String
        
        struct LanguageEntry: Decodable {
            let name: String
        }
    }
    
    struct PokemonEffectEntry: Decodable {
        let isHidden: Bool
        let pokemon: PokemonName
    }
}
