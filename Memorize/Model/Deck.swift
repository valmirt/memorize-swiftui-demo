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
        case .halloween: return ["ðŧ", "ð", "ð§ðžââïļ", "ðĶ", "ð·", "ðŽ", "ðļ", "ð§ââïļ", "ð", "â°ïļ"]
        case .animals: return ["ð", "ðĒ", "ð", "ðĶĒ", "ð", "ðŋ", "ðĶ", "ðĶ§", "ð", "ðĶ", "ð", "ð", "ð", "ðĶĻ", "ðĶ", "ðĶ", "ðĶ"]
        case .food: return ["ð", "ð", "ð", "ðĢ", "ðŠ", "ð°", "ð", "ðŪ"]
        case .flags: return ["ð§ð·", "ðĻðĶ", "ðŪðŠ", "ðšðļ", "ðšðū", "ðĶðš", "ðĐðŠ", "ðīó §ó Ēó Ĩó Ūó §ó ŋ", "ðĶð·", "ðĻðš", "ðĻðģ", "ðŊðĩ", "ð·ðš", "ðŪðļ", "ðģðŋ", "ðĩðđ", "ðŠðļ", "ðŦð·", "ð§ðŠ"]
        case .smileys: return ["ð", "ðĨ°", "ð", "ð", "ðĪ", "ðĪŠ", "ðŦ", "ðĨļ", "ðĄ", "ðĨķ", "ðĪĒ", "ð", "ðĐ"]
        case .nature: return ["ðī", "âïļ", "ð", "ðģ", "ðŠī", "ð", "ð", "ð", "ðđ", "ðū", "ðļ", "ðĩ"]
        case .sports: return ["ð", "ðū", "ð", "â―ïļ", "ðĨ", "ð", "ð", "ðđ"]
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
