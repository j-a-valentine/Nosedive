//
//  ViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import UIKit

class ViewController: UIViewController {

    var gameView:GameView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameView()
        Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(nextFrame), userInfo: nil, repeats: true)
    }
    
    func setGameView() {
        let frame = CGRect(x:0, y:50, width:self.view.frame.width, height:750)
        gameView = GameView(frame: frame)
        //gameView.backgroundColor = .systemPink
        view.addSubview(gameView)
    }
    
    @objc func nextFrame() {
        gameView.gc.updateGame()
        gameView.setNeedsDisplay()
    }
    
    
    


}

