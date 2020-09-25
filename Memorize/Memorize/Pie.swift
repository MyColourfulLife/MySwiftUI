//
//  Pie.swift
//  Memorize
//
//  Created by JiaShu Huang on 2020/9/23.
//

import SwiftUI

struct Pie:Shape {
    var startAngle:Angle
    var endAngle:Angle
    var clockwise:Bool = false
    
    var animatableData: AnimatablePair<Double,Double> {
        get {
            AnimatablePair(startAngle.radians,endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center:CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius:CGFloat = min(rect.width, rect.height)/2
        let startPoint = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians))
                                 , y: center.y + radius * sin(CGFloat(startAngle.radians)))
        var path = Path()
        path.move(to: center)
        path.addLine(to: startPoint)
        path.addArc(center: center
                    , radius: radius
                    , startAngle: startAngle
                    , endAngle: endAngle
                    , clockwise: clockwise)
        path.addLine(to: center)
        return path
    }
    
}
