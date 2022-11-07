//
//  GameController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import Foundation
import UIKit
class GameController {

    var screenWidth:CGFloat
    var screenHeight:CGFloat
    var numRows:Int
    var numCols:Int
    var tileManager:TileManager
    var isPlaying:Bool
    var gameOver:Bool
    var genTest = 0
    
    
    init(screenWidth:CGFloat, screenHeight:CGFloat, numRows:Int, numCols:Int) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.numRows = numRows
        self.numCols = numCols
        self.tileManager = TileManager(screenWidth: screenWidth, screenHeight: screenHeight, numRows: numRows, numCols: numCols)
        self.isPlaying = false
        self.gameOver = false
    }
    
    func beginGame() {
        self.isPlaying = true
    }
    
    func endGame() {
        self.isPlaying = false
        self.gameOver = true
    }
    
    func updateGame() {
        if genTest == self.numCols {
            genTest = 0
        }
        if self.tileManager.shouldGenerate() {
            self.tileManager.generateRow(openCol: genTest, width: 1)
            genTest += 1
        }
        if self.tileManager.shouldDelete() {
            self.tileManager.deleteRow()
        }
        self.tileManager.shift()
    }
    
    func drawGame() {
        self.tileManager.draw(boundColor: .red, lineColor: .blue)
    }

}
