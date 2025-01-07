//
//  String.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/6/25.
//

import SwiftUI

extension String {
    func capitalizeFirst() -> String {
        let leadingAndTrailingSpaces: CharacterSet = .whitespacesAndNewlines
        let whitespaces: CharacterSet = .whitespaces
        let trimmed = self.trimmingCharacters(in: leadingAndTrailingSpaces)
        let strings: [String] = trimmed.components(separatedBy: whitespaces)
        var result = ""
        for idx in 0..<strings.count {
            let firstLetter = strings[idx].prefix(1).capitalized
            let remainingLetters = strings[idx].dropFirst()
            result += firstLetter + remainingLetters
            result += idx == strings.count - 1 ? "" : " "
        }
        return result
    }
}
