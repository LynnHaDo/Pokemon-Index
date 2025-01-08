//
//  Pokemon.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

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
        let randomInt = Int.random(in: 1..<4)
        
        switch randomInt {
            case 1:
                return Image(.sceneOne)
            case 2:
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
