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
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
        
        self.cards = cards
    }
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: Type
    }
}
