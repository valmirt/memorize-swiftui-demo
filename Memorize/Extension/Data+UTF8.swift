//
//  Data+UTF8.swift
//  Memorize
//
//  Created by Valmir Junior on 19/04/21.
//

import Foundation

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
    
    func toModel<T: Decodable>(model: T.Type ) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(model, from: self)
    }
}
