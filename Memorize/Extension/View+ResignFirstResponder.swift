//
//  View+ResignFirstResponder.swift
//  Memorize
//
//  Created by Valmir Junior on 25/04/21.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
