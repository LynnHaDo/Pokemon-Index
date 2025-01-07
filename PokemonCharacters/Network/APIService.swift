//
//  APIService.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

struct APIService {
    static func get<T: Decodable>(_ resourceUrl: String, completion: @Sendable @MainActor @escaping (T?, Error?) -> ())
    {
        guard let url = URL(string: resourceUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print(e.localizedDescription)
                return 
            }
            
            DispatchQueue.main.async {
                if let e = error {
                    completion(nil, e)
                }
                
                if let modeledData: T = parseData(data: data) {
                    completion(modeledData, nil)
                }
            }
        }.resume() 
    }
    
    // Return data on success
    static func parseData<T: Decodable>(data: Data?) -> T? {
        guard let data = data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let modeledData = try decoder.decode(T.self, from: data)
            return modeledData
        }
        catch let error {
            print("Failed to decode: \(error)")
        }
        
        return nil
    }
}
