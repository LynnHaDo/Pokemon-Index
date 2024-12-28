//
//  Species.swift
//  PokemonCharacters
//
//  Created by Do Linh on 12/27/24.
//

struct Species: Decodable {
    let base_happinesss: Int
    let capture_rate: Int
    let color: Color
    let egg_groups: [EggGroup]
    let flavor_text_entries: [FlavorText]
    
    struct Color: Decodable {
        let name: String
        // url
    }
    
    struct EggGroup: Decodable {
        let name: String
        // url
    }
    
    struct FlavorText: Decodable {
        let flavor_text: String
        // language
        // version
    }
}
