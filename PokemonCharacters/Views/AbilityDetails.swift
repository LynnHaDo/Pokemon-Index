//
//  AbilityDetails.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/7/25.
//

import SwiftUI

struct AbilityView: View {
    let resourceUrl: String
    
    @State var ability: PokemonAbility?
    @State var errorMessage: String = ""
    @State var isDataLoading: Bool = true
    
    func getAbility() {
        APIService.get(resourceUrl) { (response: PokemonAbility?, error: Error?) in
            if let error = error {
                errorMessage = error.localizedDescription
            }
            
            if let response = response {
                ability = response
                print(response)
            }
        }
        self.isDataLoading = false
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                if (errorMessage != "")
                {
                    Text(errorMessage).caption()
                }
                else {
                    if (ability == nil) {
                        Text("Ability info is not available.")
                    }
                    else {
                        VStack {
                            ForEach(0..<ability!.effectEntries.count, id: \.self) { idx in
                                
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            getAbility()
        }
    }
}
