//
//  ThemeChooserList.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeChooserList: View {
    @ObservedObject var viewModel: MemoryGameDecksViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.decks) { deck in
                    NavigationLink(
                        destination: EmojiMemoryGameView(viewModel: deck)
                            .navigationTitle(deck.cardName)
                    ) { ThemeChooserRow(deck: deck.deck) }
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        
                    }, label: { Image(systemName: "plus").imageScale(.large) })
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserList(viewModel: MemoryGameDecksViewModel())
    }
}
