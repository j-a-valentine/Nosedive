//
//  Player.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/6/22.
//

import Foundation
import UIKit

class Player {
    var origin:CGPoint
    var length:CGFloat
    
    init(origin:CGPoint, length:CGFloat) {
        self.origin = origin
        self.length = length
    }
    
    func move(to:CGFloat) {
        self.origin.x = to
    }
    
    func draw(color:UIColor) {
        let path = UIBezierPath()
        path.move(to: self.origin)
        path.addLine(to: CGPoint(x:self.origin.x+self.length, y:self.origin.y))
        path.addLine(to: CGPoint(x:self.origin.x+self.length, y:self.origin.y+self.length))
        path.addLine(to: CGPoint(x:self.origin.x, y:self.origin.y+self.length))
        path.addLine(to: self.origin)
        color.setFill()
        path.fill()
        path.close()
    }
}
