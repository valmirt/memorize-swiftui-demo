//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let viewModel: MemoryGameDecksViewModel
    
    init() {
        viewModel = MemoryGameDecksViewModel()
        if viewModel.decks.isEmpty {
            for deck in Deck.allCases {
                viewModel.addNew(deck: Deck.CustomDeck(with: deck), named: deck.rawValue)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserList(viewModel: viewModel)
        }
    }
}
