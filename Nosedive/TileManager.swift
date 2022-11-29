//
//  TileManager.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import Foundation
import UIKit

class TileManager {
    
    var tiles:[[Tile]]
    var screenWidth:CGFloat
    var screenHeight:CGFloat
    var numRows:Int
    var numCols:Int
    var finishLine:Tile?
    
    init(screenWidth:CGFloat, screenHeight:CGFloat, numRows:Int, numCols:Int) {
        self.tiles = []
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.numRows = numRows
        self.numCols = numCols
    }

    var rowSize:CGFloat {
        return self.screenHeight / CGFloat(self.numRows)
    }
    
    var colSize:CGFloat {
        return self.screenWidth / CGFloat(self.numCols)
    }
    
    var offScreenSpawnY:CGFloat {
        return self.screenHeight
    }
    
    var shiftBy:CGFloat {
        return self.rowSize/30
    }
    
    func generateRow(openCol:Int, width:Int) {
        guard openCol >= 0 && openCol+width-1 < self.numCols else { return }
        let col = CGFloat(openCol)
        var row:[Tile] = []
        let leftTile = Tile(origin:CGPoint(x:0, y:self.offScreenSpawnY), width:self.colSize*col, height:self.rowSize)
        row.append(leftTile)
        let centerTile = Tile(origin:CGPoint(x:self.colSize*col, y:self.offScreenSpawnY), width:self.colSize*CGFloat(width), height:self.rowSize)
        row.append(centerTile)
        let rightTile = Tile(origin:CGPoint(x:self.colSize*(col+CGFloat(width)), y:self.offScreenSpawnY), width:(CGFloat(self.numCols)-(col+CGFloat(width)))*self.colSize, height:self.rowSize)
        row.append(rightTile)
        self.tiles.append(row)
    }
    
    func deleteRow() {
        guard self.tiles.count > 0 else { return }
        self.tiles.removeFirst()
    }
    
    func shift() {
        for r in self.tiles{
            for t in r {
                t.shift(shiftBy:self.shiftBy)
            }
        }
        self.finishLine?.shift(shiftBy: self.shiftBy)
    }
    
    func shiftFull() {
        for r  in self.tiles {
            for t in r {
                t.shift(shiftBy: self.rowSize)
            }
        }
    }
    
    func shouldGenerate() -> Bool {
        
        if self.tiles.count == 0 {
            return true
        }
        if self.tiles[self.tiles.count-1][0].origin.y == self.screenHeight - self.rowSize {
            //print("generate")
            return true
        }
        else {
            return false
        }
    }
    
    func shouldDelete() -> Bool {
        if self.tiles.count == 0 {
            return false
        }
        if self.tiles[0][0].origin.y <= 0 - self.rowSize {
            //print("delete")
            return true
        }
        else {
            return false
        }
    }
    
    func hasCollisionWithBoundary(player:Player) -> Bool {
        for r in self.tiles {
            for tileIndex in 0..<3 {
                if tileIndex != 1 {
                    if r[tileIndex].hasCollision(player: player) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func hasCollisionWithFinishLine(player:Player) -> Bool {
        guard let finish = self.finishLine else {
            return false
        }
        return finish.hasCollision(player: player)
        
    }
    
    func generateFinishLine() {
        self.finishLine = Tile(origin:CGPoint(x:0, y:self.offScreenSpawnY), width:self.screenWidth, height:self.screenHeight)
    }
    
    func draw(boundColor:UIColor, lineColor:UIColor, finishLineColor:UIColor) {
        var selectedColor = boundColor
        for r in self.tiles {
            var count = 1
            for t in r {
                if count % 2 == 0 {
                    selectedColor = boundColor
                }
                else{
                    selectedColor = lineColor
                }
                t.draw(color:selectedColor)
                count+=1
            }
        }
        self.finishLine?.draw(color: .purple)
        
    }
    
    func printTiles() {
        for r in self.tiles {
            for t in r {
                t.printTile()
            }
        }
    }
}

class Tile {
    
    var origin:CGPoint
    var width:CGFloat
    var height:CGFloat
    
    init(origin:CGPoint, width:CGFloat, height:CGFloat) {
        self.origin = origin
        self.width = width
        self.height = height
    }
    
    func shift(shiftBy:CGFloat) {
        self.origin.y -= shiftBy
    }
    
    func draw(color:UIColor) {
        let path = UIBezierPath()
        path.move(to:self.origin)
        path.addLine(to: CGPoint(x:self.origin.x, y:self.origin.y+self.height))
        path.addLine(to: CGPoint(x:self.origin.x+self.width, y:self.origin.y+self.height))
        path.addLine(to: CGPoint(x:self.origin.x+width, y:self.origin.y))
        path.addLine(to: (self.origin))
        color.setFill()
        path.fill()
        path.close()
    }
    
    func hasCollision(player:Player) -> Bool {
        if self.origin.x < player.origin.x + player.length && self.origin.x + self.width > player.origin.x && self.origin.y < player.origin.y + player.length && self.origin.y + self.height > player.origin.y {
            //print("Collision")
            return true
        }
        return false
    }
    
    func printTile() {
        print(self.origin)
    }
}
