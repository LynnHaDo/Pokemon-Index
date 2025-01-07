//
//  Pokemons.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import Foundation

struct Pokemons: Decodable {
    let results: [PokemonName]
}

struct PokemonName: Decodable {
    let name: String
    let url: String
}
