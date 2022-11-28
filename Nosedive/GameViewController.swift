//
//  ViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import UIKit

class GameViewController: UIViewController {

    var gameView:GameView!
    var gameLoop:Timer!
    var tileData:[[Int]]!
    var theme:Theme!
    let userDefaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let waterImage:UIImage = UIImage(named: "water_player")!
        self.theme = Theme(pathColor: .black, barrierColor: .white, backgroundImage: waterImage, playerImage: waterImage)
        setGameView()
        gameView.gc.beginGame()
        gameLoop = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(nextFrame), userInfo: nil, repeats: gameView.gc.isPlaying)
        
        
    }
    
    func setGameView() {
        let frame = CGRect(x:0, y:50, width:self.view.frame.width, height:750)
        gameView = GameView(frame: frame)
        gameView.gc.levelData.setLevelData(tileData: self.tileData)
        gameView.gc.loadTheme(theme:self.theme)
        view.addSubview(gameView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let point = (touches.first)?.location(in: gameView) else {return}
        gameView.gc.movePlayer(to:point.x)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let point = (touches.first)?.location(in: gameView) else {return}
        gameView.gc.movePlayer(to:point.x)
    }
    
    @objc func nextFrame() {
        gameView.updateGame()
        gameView.setNeedsDisplay()
        if gameView.gc.gameOver {
            gameLoop.invalidate()
            
            let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menu")
            self.navigationController?.pushViewController(menuController, animated: false)
        }
        
    }
    
    
    


}

