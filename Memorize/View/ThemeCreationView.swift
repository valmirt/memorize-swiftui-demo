//
//  ThemeCreationView.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeCreationView: View {
    @EnvironmentObject var viewModel: MemoryGameDecksViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ThemeEditView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeCreationView()
            .environmentObject(MemoryGameDecksViewModel())
    }
}
