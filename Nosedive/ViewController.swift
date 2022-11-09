//
//  ViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import UIKit

class ViewController: UIViewController {

    var gameView:GameView!
    var gameLoop:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameView()
        gameView.gc.beginGame()
        gameLoop = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(nextFrame), userInfo: nil, repeats: gameView.gc.isPlaying)
    }
    
    func setGameView() {
        let frame = CGRect(x:0, y:50, width:self.view.frame.width, height:750)
        gameView = GameView(frame: frame)
        //gameView.backgroundColor = .systemPink
        view.addSubview(gameView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = (touches.first)!.location(in: gameView) as CGPoint
        gameView.gc.movePlayer(to:point.x)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = (touches.first)!.location(in: view) as CGPoint
        gameView.gc.movePlayer(to:point.x)
    }
    
    @objc func nextFrame() {
        gameView.updateGame()
        gameView.setNeedsDisplay()
        if gameView.gc.gameOver {
            gameLoop.invalidate()
        }
        
    }
    
    
    


}

