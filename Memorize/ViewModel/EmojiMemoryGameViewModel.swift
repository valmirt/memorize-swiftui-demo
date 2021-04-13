//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

final class EmojiMemoryGameViewModel: ObservableObject {
    @Published
    private var memoryCard: MemoryGame<String> = {
        let deck = Deck.sortedDeck
        return MemoryGame<String>(numberOfPairsOfCards: deck.pairEmojisCount, backgroundCard: deck.color) { pairIndex in
            deck.emojis[pairIndex]
        }
    }()
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        memoryCard.cards
    }
    var backgroundColor: Color {
        memoryCard.backgroundCard
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryCard.choose(card: card)
    }
}
