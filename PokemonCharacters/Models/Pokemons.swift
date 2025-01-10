//
//  Pokemons.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import Foundation
import MapKit
import SwiftUI

let pokemonWrapper: PokemonWrapper = PokemonWrapper()

class PokemonWrapper: ObservableObject {
    @Published var allPokemons: [PokemonName] = []
    @Published var allNames: [String] = []
    @Published var previousTask: URLSessionTask?
    @Published var nextUrl: String?
    @Published var numPokemons: Int = 0
    
    init() {
        let url = Routes.baseUrl
        fetchData(url)
    }
    
    func fetchData(_ url: String) {
        previousTask?.cancel()
        
        previousTask = APIService.get(url) { (response: Pokemons?, error: Error?) in
            if let error = error {
                print("An error occurred while fetching more pokemon: \(error.localizedDescription)")
                self.allPokemons += []
            }
            
            if let response = response {
                self.allPokemons += response.results
                self.nextUrl = response.next
                self.numPokemons = response.count
                self.allNames = response.results.map { $0.name.capitalizeFirst() }
            }
        }
    }
}

struct Pokemons: Decodable {
    let count: Int
    let next: String?
    let results: [PokemonName]
}

struct PokemonName: Decodable {
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    var location: (String, CLLocationCoordinate2D) { locationService.getRandomPosition(name) }
    
    var imageUrl: String
    {
        guard let id = Int(url.components(separatedBy: Routes.baseUrl)[1].dropLast()) else { return "" }
        return Routes.pokemonImageUrl(id)
    }
}
