//
//  ContentView.swift
//  Memorize
//  this is View
//  Created by JiaShu Huang on 2020/9/19.
//

import SwiftUI

struct EmojiMemoryGameView: View {
   @ObservedObject var viewModel:EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards){ card in
                GridView(card: card).onTapGesture {
                    viewModel.shoose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct GridView: View {
    var card:MemoryGame<String>.Card
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                if card.isFaceUp {
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: conerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                }else {
                    RoundedRectangle(cornerRadius: conerRadius).fill(Color.orange)
                }
            }.font(.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
    
    // MARK - Drawing constants
    let conerRadius:CGFloat = 10
    let edgeLineWidth:CGFloat = 3
    let fontScaleFactor:CGFloat = 0.75
    
}
