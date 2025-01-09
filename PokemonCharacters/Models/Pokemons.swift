//
//  Pokemons.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import Foundation
import MapKit

struct Pokemons: Decodable {
    let results: [PokemonName]
}

struct PokemonName: Decodable {
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    var location: (String, CLLocationCoordinate2D) { LocationService.getRandomPosition(name) }
}
