//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import Foundation

struct MemoryGame<Type> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> Type) {
        var cards: [Card] = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        self.cards = cards
    }
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: Type
        var id: String = UUID().uuidString
    }
}
