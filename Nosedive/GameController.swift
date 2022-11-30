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
    var theme:Theme
    var finishLineGenerated:Bool
    var score:Int
    
    
    init(screenWidth:CGFloat, screenHeight:CGFloat, numRows:Int, numCols:Int) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.numRows = numRows
        self.numCols = numCols
        self.tileManager = TileManager(screenWidth: screenWidth, screenHeight: screenHeight, numRows: numRows, numCols: numCols)
        self.player = Player(origin:CGPoint(x:screenWidth/2-12, y:screenHeight/CGFloat(numRows)-12), length: 24)
        self.isPlaying = false
        self.gameOver = false
        self.levelData = LevelData(minCol:0, maxCol:numCols-1)
        self.theme = Theme()
        self.finishLineGenerated = false
        self.score = 0
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
            if data.count != 0 {
                self.tileManager.generateRow(openCol: data[0], width: data[1])
            }
            else if self.finishLineGenerated == false {
                self.finishLineGenerated = true
                self.tileManager.generateFinishLine()
            }
            
        }
        if self.tileManager.shouldDelete() {
            self.tileManager.deleteRow()
            self.score += 1
        }
        self.tileManager.shift()
    }
    
    func updateGameStatus () {
        if self.tileManager.hasCollisionWithBoundary(player: self.player) {
            self.endGame()
            print("Game Over")
        }
        if self.tileManager.hasCollisionWithFinishLine(player: self.player) {
            self.endGame()
            print("You Win")
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
        self.tileManager.draw(boundColor: theme.barrierColor, lineColor: theme.pathColor, finishLineColor:.purple)
        self.player.draw(color: .red)
        //self.player.draw(image: theme.playerImage)
    }
    
    func loadTheme(theme:Theme) {
        self.theme = theme
    }

}
