//
//  Deck.swift
//  Memorize
//
//  Created by Valmir Junior on 13/04/21.
//

import SwiftUI

enum Deck {
    case halloween, animals, food, flags, smileys, nature, sports
    
    var emojis: [String] {
        switch self {
        case .halloween: return ["👻", "🎃", "🧛🏼‍♂️", "🦇", "🕷", "🍬", "🕸", "🍭", "🧟‍♀️", "💀", "⚰️"]
        case .animals: return ["🐍", "🐢", "🐊", "🦢", "🐁", "🐿", "🐓", "🦒", "🦧", "🐋", "🦀", "🐟", "🐫", "🐘", "🐀", "🦨", "🦝", "🦜", "🦘"]
        case .food: return ["🍔", "🍟", "🍕", "🍣", "🍪", "🍰", "🍜", "🌮", "🥓", "🧀", "🌭", "🌯", "🍛", "🥗"]
        case .flags: return ["🇧🇷", "🇨🇦", "🇮🇪", "🇺🇸", "🇺🇾", "🇦🇺", "🇩🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇷", "🇨🇺", "🇨🇳", "🇯🇵", "🇷🇺", "🇮🇸", "🇳🇿", "🇵🇹", "🇪🇸", "🇫🇷", "🇧🇪"]
        case .smileys: return ["😂", "🥰", "😍", "😎", "🤓", "🤪", "😫", "🥸", "😡", "🥶", "🤢", "😈", "💩"]
        case .nature: return ["🌴", "☘️", "🍀", "🌳", "🪴", "🍂", "🍁", "🍄", "🌹", "🌾", "🌸", "🌵"]
        case .sports: return ["🏈", "🎾", "🏀", "⚽️", "🥌", "🏓", "🏒", "🛹"]
        }
    }
    
    var color: Color {
        switch self {
        case .halloween: return .orange
        case .animals: return .yellow
        case .food: return .pink
        case .flags: return .blue
        case .smileys: return .red
        case .nature: return .green
        case .sports: return .purple
        }
    }
    
    var pairEmojisCount: Int {
        Int.random(in: 3...emojis.count)
    }
    
    static var sortedDeck: Deck {
        let decks: [Deck] = [.halloween, .animals, .food, .flags, .smileys, .nature, .sports]
        return decks.shuffled().first!
    }
}
