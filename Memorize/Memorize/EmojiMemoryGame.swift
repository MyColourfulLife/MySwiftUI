//
//  EmojiMemoryGame.swift
//  Memorize
//  this is ViewModel
//  Created by JiaShu Huang on 2020/9/20.
//

import SwiftUI

class EmojiMemoryGame:ObservableObject {
   @Published private var model:MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
   static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😘","🥰"]
        return MemoryGame<String>(numberOfCards: emojis.count) { index -> String in
            emojis[index]
        }
    }
    // MARK: - Access to the model
    var cards:Array<MemoryGame<String>.Card> {model.cards}
    
    // MARK: - Intent(s)
    func shoose(card:MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card: card)
    }
    
    
}
