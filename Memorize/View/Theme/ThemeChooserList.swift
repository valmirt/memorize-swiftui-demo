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
    
    private var isEditMode: Bool {
        editMode == .active
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.decks) { document in
                    NavigationLink(
                        destination: EmojiMemoryGameView(viewModel: document)
                            .navigationTitle(document.cardName)
                    ) {
                        ThemeChooserRow(
                            deck: document.deck,
                            isEditable: isEditMode,
                            showEditTheme: $showCreationThemeView
                        )
                        .sheet(isPresented: $showCreationThemeView) {
                            ThemeCreationView(
                                isEditMode: isEditMode,
                                document: document,
                                showThemeCreation: $showCreationThemeView,
                                deckName: isEditMode ? document.deck.title : "Custom Deck",
                                chosenEmojis: isEditMode ? document.deck.emojis : ["🍄"],
                                pairCount: isEditMode ? document.deck.countPairs : 1,
                                selectedColor: isEditMode ? document.deck.color : Color.orange.rgbColor
                            )
                            .environmentObject(viewModel)
                        }
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
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserList().environmentObject(MemoryGameDecksViewModel())
    }
}
