//
//  GameView.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import Foundation
import UIKit

class GameView: UIView {
    
    var gc:GameController
    
    
    override init(frame: CGRect) {
        self.gc = GameController(screenWidth: frame.width, screenHeight: frame.height, numRows: 8, numCols: 7)
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        gc.drawGame()
    }
    
}
