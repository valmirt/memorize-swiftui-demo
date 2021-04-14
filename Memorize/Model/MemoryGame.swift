//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import Foundation

struct MemoryGame<Type> where Type: Equatable {
    var cards: [Card]
    var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> Type) {
        var cards: [Card] = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        self.cards = cards.shuffled()
    }
    
    mutating func choose(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }), !cards[index].isFaceUp, !cards[index].isMatched {
            if let potentialMachIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[index].isMatched = cards[index].content == cards[potentialMachIndex].content
                cards[potentialMachIndex].isMatched = cards[index].content == cards[potentialMachIndex].content
                cards[index].isFaceUp = true
                calculateScore(withSelectedCardAt: index, andPreviousSelectedCardAt: potentialMachIndex)
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func calculateScore(withSelectedCardAt currentIndex: Int, andPreviousSelectedCardAt previousIndex: Int) {
        if cards[currentIndex].isMatched {
            score += 2
        } else {
            if cards[currentIndex].alreadyBeenSeen {
                score -= 1
            }
            if cards[previousIndex].alreadyBeenSeen {
                score -= 1
            }
            cards[currentIndex].alreadyBeenSeen = true
            cards[previousIndex].alreadyBeenSeen = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var alreadyBeenSeen: Bool = false
        var content: Type
        var id: String = UUID().uuidString
    }
}
