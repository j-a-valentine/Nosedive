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
    var levelData:LevelData
    
    
    init(screenWidth:CGFloat, screenHeight:CGFloat, numRows:Int, numCols:Int) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.numRows = numRows
        self.numCols = numCols
        self.tileManager = TileManager(screenWidth: screenWidth, screenHeight: screenHeight, numRows: numRows, numCols: numCols)
        self.player = Player(origin:CGPoint(x:screenWidth/2-10, y:screenHeight/CGFloat(numRows)-10), length: 20)
        self.isPlaying = false
        self.gameOver = false
        self.levelData = LevelData(minCol:0, maxCol:numCols-1)
    }
    
    func beginGame() {
        self.setStartingTiles()
        self.isPlaying = true
    }
    
    func endGame() {
        self.isPlaying = false
        self.gameOver = true
    }
    
    func setStartingTiles() {
        let startingTiles = self.levelData.getPreStartBoard()
        for t in startingTiles {
            self.tileManager.generateRow(openCol: t[0], width: t[1])
            self.tileManager.shiftFull()
        }
    }
    
    func updateGameTiles() {
        
        if self.tileManager.shouldGenerate() {
            let data = self.levelData.getNextRow()
            self.tileManager.generateRow(openCol: data[0], width: data[1])
            
        }
        if self.tileManager.shouldDelete() {
            self.tileManager.deleteRow()
        }
        self.tileManager.shift()
    }
    
    func updateGameStatus () {
        if self.tileManager.hasCollisionWithBoundary(player: self.player) {
            self.endGame()
            //print("Game Over")
        }
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
