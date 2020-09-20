//
//  ContentView.swift
//  Memorize
//  this is View
//  Created by JiaShu Huang on 2020/9/19.
//

import SwiftUI

struct ContentView: View {
    var viewModel:EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards){ card in
               GridView(card: card)
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
        .frame(height:150)
    }
}

struct GridView: View {
    var card:MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content)
            }else {
                RoundedRectangle(cornerRadius: 10).fill(Color.orange)
            }
        }
    }
}
