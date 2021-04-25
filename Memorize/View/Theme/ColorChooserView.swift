//
//  ColorChooserView.swift
//  Memorize
//
//  Created by Valmir Junior on 25/04/21.
//

import SwiftUI

struct ColorChooserView: View {
    var color: Color
    var isSelected: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(color)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ZStack {
                            CheckShape()
                                .stroke(lineWidth: 2)
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.10)
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .opacity(isSelected ? 1 : 0)
                        .animation(.linear)
                    }
                }
            }
        }
    }
}

struct ColorChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ColorChooserView(color: .blue, isSelected: true)
            .previewLayout(.fixed(width: 200, height: 300))
    }
}
