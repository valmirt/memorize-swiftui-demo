//
//  MemoryGameDecksViewModel.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI
import Combine

final class MemoryGameDecksViewModel: ObservableObject {
    let name: String
    @Published private var documents: [EmojiMemoryGameViewModel : String] = [:]
    
    func name(for deck: EmojiMemoryGameViewModel) -> String {
        if documents[deck] == nil {
            documents[deck] = "Custom Deck"
        }
        return documents[deck]!
    }
    
    var decks: [EmojiMemoryGameViewModel] {
        documents.keys.sorted { documents[$0]! < documents[$1]! }
    }
    
    func addNew(deck: Deck.CustomDeck) {
        documents[EmojiMemoryGameViewModel(deck: deck)] = deck.title
    }
    
    func editDeck(_ deck: Deck.CustomDeck, for document: EmojiMemoryGameViewModel) {
        removeDeck(document)
        document.deck = deck
        documents[document] = deck.title
    }

    func removeDeck(_ document: EmojiMemoryGameViewModel) {
        documents[document] = nil
    }
    
    private var autosave: AnyCancellable?
    
    init(named name: String = "Memory Game") {
        self.name = name
        let defaultsKey = "MemoryGameDecksViewModel.\(name)"
        documents = Dictionary(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        autosave = $documents.sink { names in
            UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
        }
    }
}

extension Dictionary where Key == EmojiMemoryGameViewModel, Value == String {
    var asPropertyList: [String : String] {
        var uuidToName = [String : String]()
        for (key, value) in self {
            uuidToName[key.id.uuidString] = value
        }
        return uuidToName
    }
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let uuidToName = plist as? [String : String] ?? [:]
        for uuid in uuidToName.keys {
            self[EmojiMemoryGameViewModel(id: UUID(uuidString: uuid))] = uuidToName[uuid]
        }
    }
}
