//
//  ThemeChooserList.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeChooserList: View {
    @EnvironmentObject var viewModel: MemoryGameDecksViewModel
    @State private var showCreationThemeView = false
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.decks) { deck in
                    NavigationLink(
                        destination: EmojiMemoryGameView(viewModel: deck)
                            .navigationTitle(deck.cardName)
                    ) {
                        ThemeChooserRow(deck: deck.deck)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.decks[$0] }.forEach { deck in
                        viewModel.removeDeck(deck)
                    }
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        showCreationThemeView = true
                    }, label: { Image(systemName: "plus").imageScale(.large) })
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
        .sheet(isPresented: $showCreationThemeView) {
           ThemeCreationView(showThemeCreation: $showCreationThemeView)
                .environmentObject(viewModel)
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserList().environmentObject(MemoryGameDecksViewModel())
    }
}
