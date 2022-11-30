//
//  Theme.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/16/22.
//

import Foundation
import UIKit

class Theme {
    var pathColor:UIColor
    var barrierColor:UIColor
    var goalColor:UIColor
    var playerImage:UIImage
    
    init(pathColor:UIColor, barrierColor:UIColor, goalColor:UIColor, playerImage:UIImage) {
        self.pathColor = pathColor
        self.barrierColor = barrierColor
        self.goalColor = goalColor
        self.playerImage = playerImage
    }
    
   convenience init() {
       self.init(pathColor:.white, barrierColor:.black, goalColor:.purple, playerImage:.add)
    }
    
}
