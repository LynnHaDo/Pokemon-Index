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
    let base_experience: Int
    let height: Int
    let weight: Int
    let abilities: [Ability]
    
    func imageUrl() -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, base_experience, height, weight, abilities
    }
    
    struct Ability: Decodable {
        let ability: AbilityItem
    }
    
    struct AbilityItem: Decodable {
        let name: String
        // url
    }
}

struct Pokemons: Decodable {
    let results: [PokemonName]
    
    struct PokemonName: Decodable {
        let name: String
        let url: String
    }
}
