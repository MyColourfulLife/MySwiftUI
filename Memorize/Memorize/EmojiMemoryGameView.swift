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
        Grid(items: viewModel.cards) { card in
            GridView(card: card).onTapGesture {
                viewModel.shoose(card: card)
            }.padding(cardPadding)
        }
        .padding()
        .foregroundColor(.orange)
    }
    let cardPadding:CGFloat = 5
}

struct GridView: View {
    var card:MemoryGame<String>.Card
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if card.isFaceUp || !card.isMactched {
          ZStack {
                Pie(startAngle: .degrees(0-90), endAngle: .degrees(0+10) ,clockwise:true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
            }.font(.system(size: min(size.width, size.height) * fontScaleFactor))
//            .modifier(Cardfiy(isFaceUp:card.isFaceUp))
          .cardfiy(isFaceUp: card.isFaceUp)
        }
    }
    
    
    // MARK - Drawing constants
    
    private   let fontScaleFactor:CGFloat = 0.7
    
}
