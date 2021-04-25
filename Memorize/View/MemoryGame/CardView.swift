//
//  CardView.swift
//  Memorize
//
//  Created by Valmir Junior on 11/04/21.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(
                                startAngle: .degrees(0 - 90),
                                endAngle: .degrees(-animatedBonusRemaining * 360 - 90),
                                clockwise: true
                            )
                            .onAppear() { startBonusTimeAnimation() }
                        } else {
                            Pie(
                                startAngle: .degrees(0 - 90),
                                endAngle: .degrees(-card.bonusRemaining * 360 - 90),
                                clockwise: true
                            )
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    
                    Text(card.content)
                        .font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(
                            card.isMatched ?
                                Animation.linear(duration: 1).repeatForever(autoreverses: false)
                                : .default
                        )
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
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
