//
//  FetchController.swift
//  PokeIndex
//
//  Created by Do Linh on 1/18/25.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse, badData
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAllPokemon() async throws -> [PokemonModel] {
        var allPokemons: [PokemonModel] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        fetchComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "1302")
        ]
        
        guard let fetchURL = fetchComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let resultsDict = try JSONSerialization.jsonObject(with: data) as? [String: Any], let pokeResults = resultsDict["results"] as? [[String: String]] else {
            throw NetworkError.badData
        }
        
        for pokemon in pokeResults {
            if let url = pokemon["url"] {
                allPokemons.append(try await fetchPokemon(from: URL(string: url)!))
            }
        }
        
        return allPokemons
    }
    
    private func fetchPokemon(from url: URL) async throws -> PokemonModel {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let pokemon = try JSONDecoder().decode(PokemonModel.self, from: data)
        
        print("DEBUG: Fetched \(pokemon.id): \(pokemon.name)")
        
        return pokemon
    }
}
