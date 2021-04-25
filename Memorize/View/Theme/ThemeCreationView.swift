//
//  ThemeCreationView.swift
//  Memorize
//
//  Created by Valmir Junior on 23/04/21.
//

import SwiftUI

struct ThemeCreationView: View {
    @EnvironmentObject var viewModel: MemoryGameDecksViewModel
    @Binding var showThemeCreation: Bool
    @State private var deckName: String = ""
    @State private var chosenEmojis: [String] = ["🍄"]
    @State private var emojiToAdd = ""
    @State private var pairCount = 1
    @State private var selectedColor: Color = .orange
    
    var body: some View {
        VStack {
            ZStack {
                Text("Create Theme")
                    .font(.headline)
                HStack {
                    Spacer()
                    Button("Done") {
                        showThemeCreation = false
                    }
                }
            }
            .padding()
            Form {
                SectionThemeName(deckName: $deckName)
                SectionAddEmoji(emojiToAdd: $emojiToAdd)
                SectionChosenEmoji(chosenEmojis: $chosenEmojis)
                SectionPairCount(pairCount: $pairCount, maxPair: chosenEmojis.count)
                SectionColorSelectorView(selectedColor: $selectedColor)
            }
        }
    }
}

//MARK: - Header View
struct EmojiHeader: View {
    var body: some View {
        HStack {
            Text("Emojis")
            Spacer()
            Text("Tap emoji to remove")
                .textCase(.lowercase)
            
        }
    }
}

//MARK: - Deck Name View
struct SectionThemeName: View {
    @Binding var deckName: String
    
    var body: some View {
        Section {
            TextField("Theme Name", text: $deckName, onEditingChanged: { began in
                if !began {
                    
                }
            })
        }
    }
}

//MARK: - Add Emoji View
struct SectionAddEmoji: View {
    @Binding var emojiToAdd: String
    
    var body: some View {
        Section(header: Text("Add Emoji")) {
            ZStack {
                TextField("Emoji", text: $emojiToAdd)
                HStack {
                    Spacer()
                    Button("Add") {
                        
                    }
                }
            }
        }
    }
}

//MARK: - Chosen Emoji View
struct SectionChosenEmoji: View {
    @Binding var chosenEmojis: [String]
    
    var body: some View {
        Section(header: EmojiHeader()) {
            Grid(chosenEmojis) { emoji in
                Text(emoji)
                    .font(Font.system(size: fontSize))
                    .onTapGesture {
                        
                    }
            }
            .frame(height: height)
        }
    }
    
    let fontSize: CGFloat = 38
    var height: CGFloat {
        CGFloat((chosenEmojis.count - 1) / 6) * 70 + 70
    }
}

//MARK: - Pair Count View
struct SectionPairCount: View {
    @Binding var pairCount: Int
    var maxPair: Int
    
    var body: some View {
        Section(header: Text("Card Count")) {
            HStack {
                Text("\(pairCount) \(pairCount == 1 ? "Pair" : "Pairs")")
                Spacer()
                Stepper(
                    onIncrement: {
                        if pairCount < maxPair {
                            pairCount += 1
                        }
                    },
                    onDecrement: {
                        if pairCount > 1 {
                            pairCount -= 1
                        }
                    },
                    label: { EmptyView() }
                )
            }
        }
    }
}

//MARK: - Color Selector View
struct SectionColorSelectorView: View {
    @Binding var selectedColor: Color
    
    var body: some View {
        Section(header: Text("Color")) {
            Grid(ThemeColor.allCases) { color in
                ColorChooserView(color: color.color, isSelected: selectedColor == color.color)
                    .padding(5)
                    .onTapGesture {
                        selectedColor = color.color
                    }
            }
            .frame(height: colorHeight)
        }
    }
    
    var colorHeight: CGFloat {
        CGFloat((ThemeColor.allCases.count - 1) / 6) * 70 + 70
    }
    
    enum ThemeColor: CaseIterable, Identifiable {
        case orange, yellow, purple, pink, blue, red, green, gray, black
        
        var color: Color {
            switch self {
            case .orange: return .orange
            case .yellow: return .yellow
            case .purple: return .purple
            case .pink: return .pink
            case .blue: return .blue
            case .red: return .red
            case .green: return .green
            case .gray: return .gray
            case .black: return .black
            }
        }
        
        var id: ThemeColor { self }
    }
}

struct ThemeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeCreationView(showThemeCreation: .constant(true))
            .environmentObject(MemoryGameDecksViewModel())
    }
}
