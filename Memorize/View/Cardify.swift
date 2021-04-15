//
//  Cardify.swift
//  Memorize
//
//  Created by Valmir Junior on 14/04/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        }
    }
    
    //MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeWidth: CGFloat = 3
}
