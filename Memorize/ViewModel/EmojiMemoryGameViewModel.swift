//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

final class EmojiMemoryGameViewModel: ObservableObject, Hashable, Identifiable {
    let id: UUID
    let defaultsKey: String
    var deck: Deck.CustomDeck {
        didSet {
            UserDefaults.standard.set(deck.json, forKey: defaultsKey)
        }
    }
    @Published private var memoryCard: MemoryGame<String>
    
    init(deck: Deck.CustomDeck? = nil, id: UUID? = nil) {
        self.id = id ?? UUID()
        let defaultsKey = "EmojiMemoryGameViewModel.\(self.id.uuidString)"
        self.defaultsKey = defaultsKey
        let safeDeck = deck ?? UserDefaults.standard.data(forKey: defaultsKey)?.toModel(model: Deck.CustomDeck.self) ?? Deck.CustomDeck(with: Deck.sortedDeck)
        self.deck = safeDeck
        UserDefaults.standard.set(self.deck.json, forKey: defaultsKey)
        memoryCard = MemoryGame<String>(numberOfPairsOfCards: self.deck.countPairs) { pairIndex in
            safeDeck.emojis[pairIndex]
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: EmojiMemoryGameViewModel, rhs: EmojiMemoryGameViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        memoryCard.cards
    }
    var cardsColor: Color {
        Color(deck.color)
    }
    var cardName: String {
        deck.title
    }
    var gameScore: Int {
        memoryCard.score
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryCard.choose(card: card)
    }
    
    func startNewGame() {
        memoryCard = MemoryGame<String>(numberOfPairsOfCards: deck.countPairs) { pairIndex in
            deck.emojis[pairIndex]
        }
    }
}
