//
//  ThemeChooserRow.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeChooserRow: View {
    var deck: Deck.CustomDeck
    
    var pairs: String {
        if deck.countPairs == deck.emojis.count {
            return "All of"
        }
        return "\(deck.countPairs) pairs from"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(deck.title)
                    .font(.title2)
                    .foregroundColor(Color(deck.color))
                HStack {
                    Text(pairs)
                        .padding(.trailing, 4)
                        .layoutPriority(1)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(deck.emojis, id: \.self) { emoji in
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
            ThemeChooserRow(deck: Deck.CustomDeck(with: .halloween))
            ThemeChooserRow(deck: Deck.CustomDeck(with: .flags))
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
}
