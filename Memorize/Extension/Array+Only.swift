//
//  Array+Only.swift
//  Memorize
//
//  Created by Valmir Junior on 12/04/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
