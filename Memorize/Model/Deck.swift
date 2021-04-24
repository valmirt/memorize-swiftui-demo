//
//  Deck.swift
//  Memorize
//
//  Created by Valmir Junior on 13/04/21.
//

import SwiftUI

enum Deck: String, CaseIterable, Identifiable {
    case halloween = "Halloween"
    case animals = "Animals"
    case food = "Food"
    case flags = "Flags"
    case smileys = "Smileys"
    case nature = "Nature"
    case sports = "Sports"
    
    var id: Deck { self }
    
    var emojis: [String] {
        switch self {
        case .halloween: return ["👻", "🎃", "🧛🏼‍♂️", "🦇", "🕷", "🍬", "🕸", "🧟‍♀️", "💀", "⚰️"]
        case .animals: return ["🐍", "🐢", "🐊", "🦢", "🐁", "🐿", "🦒", "🦧", "🐋", "🦀", "🐟", "🐘", "🐀", "🦨", "🦝", "🦜", "🦘"]
        case .food: return ["🍔", "🍟", "🍕", "🍣", "🍪", "🍰", "🍜", "🌮"]
        case .flags: return ["🇧🇷", "🇨🇦", "🇮🇪", "🇺🇸", "🇺🇾", "🇦🇺", "🇩🇪", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇷", "🇨🇺", "🇨🇳", "🇯🇵", "🇷🇺", "🇮🇸", "🇳🇿", "🇵🇹", "🇪🇸", "🇫🇷", "🇧🇪"]
        case .smileys: return ["😂", "🥰", "😍", "😎", "🤓", "🤪", "😫", "🥸", "😡", "🥶", "🤢", "😈", "💩"]
        case .nature: return ["🌴", "☘️", "🍀", "🌳", "🪴", "🍂", "🍁", "🍄", "🌹", "🌾", "🌸", "🌵"]
        case .sports: return ["🏈", "🎾", "🏀", "⚽️", "🥌", "🏓", "🏒", "🛹"]
        }
    }
    
    var defaultColor: Color {
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
    
    static var sortedDeck: Deck {
        let decks: [Deck] = [.halloween, .animals, .food, .flags, .smileys, .nature, .sports]
        return decks.shuffled().first!
    }
    
    struct CustomDeck: Codable {
        var title: String
        var emojis: [String]
        var color: UIColor.RGB
        var countPairs: Int
        
        init(with deck: Deck) {
            title = deck.rawValue
            emojis = deck.emojis
            color = deck.defaultColor.rgbColor
            countPairs = deck.emojis.count
        }
        
        init(title: String, emojis: [String], color: Color, countPairs: Int) {
            self.title = title
            self.emojis = emojis
            self.color = color.rgbColor
            self.countPairs = countPairs > emojis.count ? emojis.count : countPairs
        }
        
        var json: Data? {
            return try? JSONEncoder().encode(self)
        }
    }
}
