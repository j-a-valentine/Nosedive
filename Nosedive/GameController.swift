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
    var player:Player
    var isPlaying:Bool
    var gameOver:Bool
    var genTest = 0
    
    
    init(screenWidth:CGFloat, screenHeight:CGFloat, numRows:Int, numCols:Int) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.numRows = numRows
        self.numCols = numCols
        self.tileManager = TileManager(screenWidth: screenWidth, screenHeight: screenHeight, numRows: numRows, numCols: numCols)
        self.player = Player(origin:CGPoint(x:screenWidth/2-15, y:screenHeight/CGFloat(numRows)-15), length: 30)
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
    
    func movePlayer(to: CGFloat) {
        var left = to-self.player.length/2
        if left < 0 {
            left = 0
        }
        if left > self.screenWidth-self.player.length {
            left = self.screenWidth - self.player.length
        }
        self.player.move(to: left)
    }
    
    func drawGame() {
        self.tileManager.draw(boundColor: .red, lineColor: .blue)
        self.player.draw(color: .orange)
    }

}
