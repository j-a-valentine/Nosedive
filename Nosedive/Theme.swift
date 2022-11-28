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
    var backgroundImage:UIImage
    var playerImage:UIImage
    
    init(pathColor:UIColor, barrierColor:UIColor, backgroundImage:UIImage, playerImage:UIImage) {
        self.pathColor = pathColor
        self.barrierColor = barrierColor
        self.backgroundImage = backgroundImage
        self.playerImage = playerImage
    }
    
   convenience init() {
       self.init(pathColor:.white, barrierColor:.black, backgroundImage:.actions, playerImage:.add)
    }
    
}
