//
//  ContentView.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.75)) {
                                viewModel.choose(card: card)
                            }
                        }
                }
                Text("Score: \(viewModel.gameScore)")
                    .font(.title)
            }
            .foregroundColor(viewModel.cardsColor)
            .padding()
            .navigationTitle(viewModel.cardName)
            .toolbar(content: {
                Button("New Game") { viewModel.newGame() }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGameViewModel())
    }
}
