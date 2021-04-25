//
//  CheckShape.swift
//  Memorize
//
//  Created by Valmir Junior on 25/04/21.
//

import SwiftUI

struct CheckShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let leading = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let topTrailing = CGPoint(x: rect.maxX, y: rect.minY)
        
        var path = Path()
        
        path.move(to: leading)
        path.addLines([leading, bottom, topTrailing])
        
        return path
    }
}
