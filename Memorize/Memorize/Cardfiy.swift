//
//  Cardfiy.swift
//  Memorize
//
//  Created by JiaShu Huang on 2020/9/23.
//

import SwiftUI

struct Cardfiy:ViewModifier {
    var isFaceUp:Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
            RoundedRectangle(cornerRadius: conerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: conerRadius).stroke(lineWidth: edgeLineWidth)
            content
            }else {
                RoundedRectangle(cornerRadius: conerRadius).fill(Color.orange)
            }
        }
    }
    
    private   let conerRadius:CGFloat = 10
    private   let edgeLineWidth:CGFloat = 3
}

extension View {
    func cardfiy(isFaceUp:Bool) -> some View {
        self.modifier(Cardfiy(isFaceUp: isFaceUp))
    }
}
