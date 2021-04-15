//
//  View+Cardify.swift
//  Memorize
//
//  Created by Valmir Junior on 14/04/21.
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
