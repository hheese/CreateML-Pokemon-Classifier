//
//  WhosThatPokemonApp.swift
//  WhosThatPokemon
//
//  Created by Henry Heese on 12/8/22.
//

import SwiftUI

@main
struct WhosThatPokemonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
