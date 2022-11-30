//
//  LevelData.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/9/22.
//

import Foundation

class LevelData {
    var minCol:Int
    var maxCol:Int
    var tileData:[[Int]]
    var tracker:Int
    var canGenerate:Bool
    
    init(minCol:Int, maxCol:Int, tileData:[[Int]]) {
        self.minCol = minCol
        self.maxCol = maxCol
        self.tileData = tileData
        self.tracker = 0
        self.canGenerate = true
    }
    
    convenience init(minCol:Int, maxCol:Int) {
        self.init(minCol:minCol, maxCol:maxCol, tileData:[])
    }
    
    func setLevelData(tileData:[[Int]]) {
        self.tileData = tileData
        self.canGenerate = (tileData.count <= 0)
    }
    
    func getNextRow(isSimple:Bool) -> [Int]{
        while(self.tracker >= self.tileData.count){
            if self.canGenerate == false {
                return []
            }
            if isSimple {
                self.generateEasyPath()
            }
            else {
                self.generatePath()
            }
        }
        let data = self.tileData[self.tracker]
        self.tracker+=1
        return data
    }
    
    func getPreStartBoard() -> [[Int]]{
        var beginningList:[[Int]] = []
        for x in minCol ... maxCol/2 {
            for _ in 0 ..< 2 {
                beginningList.append([x, maxCol+1-2*x])
            }
        }
        return beginningList
    }
    
    
    
    func generateEasyPath() {
        var shouldMove = false
        let moveChance = 0.5
        if self.tileData.count == 0 {
            let col = (self.maxCol - self.minCol)/2
            let width = 1
            self.tileData.append([col, width])
            return
        }
        var random = Int.random(in: 0..<100)
        if random < Int(moveChance*100) {
            shouldMove = true
        }
        if shouldMove == true {
            var moveDirection = 1
            let lastCol = self.tileData[self.tileData.count-1][0]
            if lastCol == self.minCol {
                moveDirection = 1
            }
            else if lastCol == self.maxCol {
                moveDirection = -1
            }
            else {
                random = Int.random(in:0..<2)
                if random == 0 {
                    moveDirection = -1
                }
            }
            let col = lastCol+1*moveDirection
            if moveDirection == 1 {
                self.tileData.append([lastCol, 2])
            }
            else{
                self.tileData.append([col, 2])
            }
            self.tileData.append([col, 1])
            return
        }
        
        if shouldMove == false {
            let col = self.tileData[self.tileData.count-1][0]
            let width = 1
            self.tileData.append([col, width])
            return
        }
        
        
    }
    
    func generatePath() {
        if self.tileData.count == 0 {
            let col = (self.maxCol - self.minCol)/2
            let width = 1
            self.tileData.append([col, width])
            return
        }
        
        let col = Int.random(in: self.minCol...self.maxCol)
        
        let lastCol = self.tileData[self.tileData.count-1][0]
        
        if col == lastCol {
            self.tileData.append([col, 1])
            return
        }
        
        else if col > lastCol {
            let width = col - lastCol + 1
            self.tileData.append([lastCol, width])
            if width > 4 {
                self.tileData.append([lastCol + 3, width - 3])
            }
            self.tileData.append([col, 1])
            return
        }
        
        else{
            let width = lastCol - col + 1
            if width > 4{
                self.tileData.append([col + 3, width - 3])
            }
            self.tileData.append([col, width])
            self.tileData.append([col, 1])
            return
        }
        
            
    }
        
        
    
}
