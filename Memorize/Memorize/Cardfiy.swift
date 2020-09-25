//
//  Cardfiy.swift
//  Memorize
//
//  Created by JiaShu Huang on 2020/9/23.
//

import SwiftUI

struct Cardfiy:AnimatableModifier {
    var rotation:Double
    
    var isFaceUp:Bool {
        rotation < 90
    }
    
    init(isFaceUp:Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: conerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: conerRadius).fill(Color.orange)
                .opacity(isFaceUp ? 0 : 1)
        }.rotation3DEffect(.degrees(rotation), axis: (0,1,0))

    }
    
    private   let conerRadius:CGFloat = 10
    private   let edgeLineWidth:CGFloat = 3
}

extension View {
    func cardfiy(isFaceUp:Bool) -> some View {
        self.modifier(Cardfiy(isFaceUp: isFaceUp))
    }
}
