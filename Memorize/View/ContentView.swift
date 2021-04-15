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
            ZStack {
                HStack {
                    Spacer()
                    Button("New Game") { viewModel.newGame() }
                        .foregroundColor(.blue)
                }
                Text(viewModel.cardName)
                    .font(.title)
            }
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
                .font(.title2)
        }
        .foregroundColor(viewModel.cardsColor)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGameViewModel())
    }
}
