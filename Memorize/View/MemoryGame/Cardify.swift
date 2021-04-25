//
//  Cardify.swift
//  Memorize
//
//  Created by Valmir Junior on 14/04/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    private var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    //MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeWidth: CGFloat = 3
}
