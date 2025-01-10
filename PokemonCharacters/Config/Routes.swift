//
//  Routes.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//


struct Routes {
    static let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    static let allUrl = "?limit=100"
    static func pokemonImageUrl(_ pokemonId: Int) -> String { "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png"
    }
}
