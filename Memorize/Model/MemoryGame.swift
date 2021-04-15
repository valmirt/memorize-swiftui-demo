//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import Foundation

struct MemoryGame<Type> where Type: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
    
    private mutating func calculateScore(withSelectedCardAt currentIndex: Int, andPreviousSelectedCardAt previousIndex: Int) {
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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var alreadyBeenSeen: Bool = false
        var content: Type
        var id: String = UUID().uuidString
        
        //MARK: - Bonus Time
        
        //this could give matching bonus points
        //if the user matches the card
        //before a certain amount of time passes during which the card is face up
        
        //can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        //how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            return pastFaceUpTime
        }
        //the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        //the accumulated time this card has been face up in the past
        //(i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        //how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        //percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        //whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        //whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        //called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        //called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
