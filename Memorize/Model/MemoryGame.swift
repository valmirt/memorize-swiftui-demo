//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

struct MemoryGame<Type> where Type: Equatable {
    var cards: [Card]
    var backgroundCard: Color
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, backgroundCard: Color, cardContentFactory: (Int) -> Type) {
        var cards: [Card] = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        self.cards = cards.shuffled()
        self.backgroundCard = backgroundCard
    }
    
    mutating func choose(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }), !cards[index].isFaceUp, !cards[index].isMatched {
            if let potentialMachIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[index].isMatched = cards[index].content == cards[potentialMachIndex].content
                cards[potentialMachIndex].isMatched = cards[index].content == cards[potentialMachIndex].content
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: Type
        var id: String = UUID().uuidString
    }
}
