//
//  FilterService.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

struct FilterService {
    
    // Filter a given property by a keyword
    static func search <T: Decodable>  (_ keyword: String,
                                        from list: [T]?,
                                        prop property: KeyPath<T, String>) -> [T] {
        
        guard let list else { return [] }
        
        let key = keyword.trimLeadingAndTrailingSpaces()
        
        if key.isEmpty {
            return list
        }
        else {
            return list.filter {
                item in
                item[keyPath: property].localizedCaseInsensitiveContains(key)
            }
        }
    }
    
    // Sort a string property alphabetically
    static func sort<T: Decodable, KeyType: Comparable>(from list: [T]?,
                                                        prop property: KeyPath<T, KeyType>,
                                                        ascending: Bool = true) -> [T] {
        guard let list else { return [] }
        
        var returnedList = list
        
        returnedList.sort { (item1: T, item2: T) in
            if (ascending) {
                item1[keyPath: property] < item2[keyPath: property]
            }
            else {
                item1[keyPath: property] > item2[keyPath: property]
            }
        }
        
        return returnedList
    }
}
