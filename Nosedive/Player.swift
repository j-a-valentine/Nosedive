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
    
    func move(to:CGPoint) {
        //self.origin = to
    }
    
    func draw(color:UIColor) {
        let path = UIBezierPath()
        path.move(to: origin)
        //path.addLine(to: <#T##CGPoint#>)
    }
}
