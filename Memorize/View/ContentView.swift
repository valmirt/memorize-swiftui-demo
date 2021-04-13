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
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .onTapGesture { self.viewModel.choose(card: card) }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGameViewModel())
    }
}
