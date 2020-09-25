//
//  MemoryGame.swift
//  Memorize
//  this is Model
//  Created by JiaShu Huang on 2020/9/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards:Array<Card>
    
    init(numberOfCards:Int,cardContentFactory:(Int)->CardContent) {
        cards = Array<Card>()
        for pairIndex in 0 ..< numberOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: 2*pairIndex))
            cards.append(Card(content: content, id: 2*pairIndex + 1))
        }
        cards.shuffle()
    }
 
// 游戏规则
// 启动时所有卡片都是反面
// 点开第一个卡片时，翻开卡片
// 点开第二哥卡片时，和第一个卡片进行对比
// 点开第三张卡片时，合上其他卡片
    
    var indexOfTheOneAndOnlyFaceupCard:Int? {
        get {
//            var faceupCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceupCardIndices.append(index)
//                }
//            }
            cards.indices.filter{cards[$0].isFaceUp}.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
   mutating func choose(card:Card) {
        print("card choosen:\(card)")
    if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
        if let potentialMactchIndex = indexOfTheOneAndOnlyFaceupCard {
            if cards[choosenIndex].content == cards[potentialMactchIndex].content {
                // matched
                cards[choosenIndex].isMatched = true
                cards[potentialMactchIndex].isMatched = true
            }
//            indexOfTheOneAndOnlyFaceupCard = nil
            cards[choosenIndex].isFaceUp = true
        }else {
//            for index in cards.indices {
//                cards[index].isFaceUp = false
////                cards[index].isMactched = false
//            }
            indexOfTheOneAndOnlyFaceupCard = choosenIndex
        }
            
        }
    }
    
    struct Card:Identifiable {
        var isFaceUp:Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched:Bool = false {
            didSet{
               stopUsingBonusTime()
            }
        }
        var content:CardContent
        var id: Int
        
        // Bonustime
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        
    }
    
    
}
