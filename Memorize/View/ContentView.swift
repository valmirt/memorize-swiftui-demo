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
        VStack {
            HStack {
                Spacer()
                Button("New Game") { viewModel.newGame() }
            }
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture { viewModel.choose(card: card) }
            }
            .foregroundColor(viewModel.backgroundColor)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGameViewModel())
    }
}
