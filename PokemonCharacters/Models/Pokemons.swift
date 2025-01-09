//
//  Pokemons.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import Foundation
import MapKit
import SwiftUI

class PokemonWrapper: ObservableObject {
    @Published var allPokemons: [PokemonName] = []
    @Published var allNames: [String] = []
    @Published var previousTask: URLSessionTask?
    
    init() {
        let url = Routes.baseUrl
        
        previousTask?.cancel()
        
        previousTask = APIService.get(url) { (response: Pokemons?, error: Error?) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                self.allPokemons = []
            }
            
            if let response = response {
                self.allPokemons = response.results
                self.allNames = response.results.map { $0.name.capitalizeFirst() }
                
            }
        }
    }
}

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
    
    var imageUrl: String
    {
        guard let id = Int(url.components(separatedBy: Routes.baseUrl)[1].dropLast()) else { return "" }
        return Routes.pokemonImageUrl(id)
    }
}
