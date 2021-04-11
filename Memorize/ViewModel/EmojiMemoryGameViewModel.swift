//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import Foundation

final class EmojiMemoryGameViewModel {
    private lazy var memoryCard: MemoryGame<String> = {
        let emojis = ["👻", "🎃", "🧛🏼‍♂️", "🦇", "🕷", "🍬", "🕸", "🍭", "🧟‍♀️"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }()
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        memoryCard.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryCard.choose(card: card)
    }
}
