//
//  Grid.swift
//  Memorize
//
//  Created by Valmir Junior on 12/04/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                let index = items.firstIndex(where: { $0.id == item.id })!
                let layout = GridLayout(itemCount: items.count, in: geometry.size)
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        let cards = [
            MemoryGame<String>.Card(isFaceUp: true, content: "🧛🏼‍♂️"),
            MemoryGame<String>.Card(isFaceUp: true, content: "👻"),
            MemoryGame<String>.Card(isFaceUp: true, content: "🎃"),
        ]
        return Grid(cards) { CardView(card: $0).padding(5) }.padding()
    }
}
