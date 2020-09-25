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
        VStack {
            Grid(items: viewModel.cards) { card in
                GridView(card: card).onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.75)) {
                        viewModel.shoose(card: card)
                    }
                }.padding(cardPadding)
            }
            .padding()
            .foregroundColor(.orange)
            
            Button("New Game") {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }
        }
        
        
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-animatedBonusRemaining*360-90) ,clockwise:true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    }else {
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-card.bonusRemaining * 360-90) ,clockwise:true)
                    }
                }.padding(5)
                .opacity(0.4)
                
                Text(card.content)
                    .font(.system(size: min(size.width, size.height) * fontScaleFactor))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardfiy(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    
    // MARK - Drawing constants
    
    private   let fontScaleFactor:CGFloat = 0.7
    
}
