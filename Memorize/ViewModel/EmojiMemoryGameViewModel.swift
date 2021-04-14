//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

final class EmojiMemoryGameViewModel: ObservableObject {
    @Published
    private var memoryCard: MemoryGame<String> = EmojiMemoryGameViewModel.createMemoryGame()
    private static var deck = Deck.sortedDeck
    
    static private func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: deck.pairEmojisCount) { pairIndex in
            deck.emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        memoryCard.cards
    }
    var cardsColor: Color {
        EmojiMemoryGameViewModel.deck.color
    }
    var cardName: String {
        EmojiMemoryGameViewModel.deck.rawValue
    }
    var gameScore: Int {
        memoryCard.score
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryCard.choose(card: card)
    }
    
    func newGame() {
        EmojiMemoryGameViewModel.deck = Deck.sortedDeck
        memoryCard = EmojiMemoryGameViewModel.createMemoryGame()
    }
}
