//
//  CardView.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: edgeWidth)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill()
                }
            }
            .font(.system(size: fontSize(for: geometry.size)))
        }
    }
    
    //MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10
    let edgeWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame<String>.Card(isFaceUp: true, content: "👻"))
            .previewLayout(.fixed(width: 200, height: 300))
            .padding()
    }
}
