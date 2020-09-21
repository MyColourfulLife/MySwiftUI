//
//  MemoryGame.swift
//  Memorize
//  this is Model
//  Created by JiaShu Huang on 2020/9/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards:Array<Card>
    
    init(numberOfCards:Int,cardContentFactory:(Int)->CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: 2*pairIndex))
            cards.append(Card(content: content, id: 2*pairIndex + 1))
        }
    }
    
   mutating func choose(card:Card) {
        print("card choosen:\(card)")
        if let index = self.index(of: card) {
            cards[index].isFaceUp = !cards[index].isFaceUp
        }
    }
    
    func index(of card:Card) -> Int? {
        for index in 0..<cards.count {
            if card.id == cards[index].id {
                return index
            }
        }
        return nil
    }
    
    struct Card:Identifiable {
        var isFaceUp:Bool = false
        var isMactched:Bool = false
        var content:CardContent
        var id: Int
    }
}
