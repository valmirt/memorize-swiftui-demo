//
//  ThemeChooserRow.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeChooserRow: View {
    var document: EmojiMemoryGameViewModel
    var isEditable: Bool
    @Binding var showEditTheme: Bool
    @Binding var documentToEdit: EmojiMemoryGameViewModel
    
    var pairs: String {
        if document.deck.countPairs == document.deck.emojis.count {
            return "All of"
        }
        return "\(document.deck.countPairs) pairs from"
    }
    
    var body: some View {
        HStack {
            if isEditable {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.purple)
                    .padding(8)
                    .onTapGesture {
                        documentToEdit = document
                        showEditTheme = true
                    }
            }
            VStack(alignment: .leading) {
                Text(document.deck.title)
                    .font(.title2)
                    .foregroundColor(Color(document.deck.color))
                HStack {
                    Text(pairs)
                        .padding(.trailing, 4)
                        .layoutPriority(1)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(document.deck.emojis, id: \.self) { emoji in
                                Text(emoji)
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                
            }
            Spacer()
        }
    }
}

struct ThemeChooserRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemeChooserRow(document: EmojiMemoryGameViewModel(deck: Deck.CustomDeck(with: .halloween)), isEditable: false, showEditTheme: .constant(false), documentToEdit: .constant(.init()))
            ThemeChooserRow(document: EmojiMemoryGameViewModel(deck: Deck.CustomDeck(with: .flags)), isEditable: true, showEditTheme: .constant(false), documentToEdit: .constant(.init()))
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
}
