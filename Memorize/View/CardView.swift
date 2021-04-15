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
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90), clockwise: true)
                        .padding(5)
                        .opacity(0.4)
                    Text(card.content)
                        .font(.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
    
    //MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.7
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame<String>.Card(isFaceUp: true, content: "👻"))
            .previewLayout(.fixed(width: 200, height: 300))
            .foregroundColor(.orange)
            .padding()
    }
}
