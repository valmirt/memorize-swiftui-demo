//
//  Data+UTF8.swift
//  Memorize
//
//  Created by Valmir Junior on 19/04/21.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
