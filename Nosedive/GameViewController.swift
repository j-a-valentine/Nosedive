//
//  ViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import UIKit

class GameViewController: UIViewController {

    var gameView:GameView!
    var scoreLabel:UILabel!
    var gameLoop:Timer!
    var tileData:[[Int]]!
    var themes:[Theme] = []
    var theme:Theme!
    let userDefaults = UserDefaults.standard

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadThemes()
        selectTheme()
        setGameView()
        gameView.gc.beginGame()
        gameLoop = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(nextFrame), userInfo: nil, repeats: gameView.gc.isPlaying)
        
        
    }
    
    func loadThemes() {
        themes.append(Theme(pathColor: .white, barrierColor: .red, goalColor:.systemPink, playerImage: UIImage(named: "fire_player")!))
        themes.append(Theme(pathColor: .blue, barrierColor: .white, goalColor:.systemPink, playerImage: UIImage(named: "water_player")!))
        themes.append(Theme(pathColor: UIColor(red: 135/255, green: 200/255, blue: 235/255, alpha: 1), barrierColor: .green, goalColor:.systemPink, playerImage: UIImage(named: "earth_player")!))
        themes.append(Theme(pathColor: .white, barrierColor: .black, goalColor:.systemPink, playerImage: UIImage(named: "space_player")!))
    }
    
    func selectTheme() {
        self.theme = themes[userDefaults.integer(forKey: "theme")]
    }
    
    func setGameView() {
        
        let frame = CGRect(x:0, y:100, width:self.view.frame.width, height:750)
        gameView = GameView(frame: frame)
        gameView.gc.levelData.setLevelData(tileData: self.tileData)
        gameView.gc.loadTheme(theme:self.theme)
        view.addSubview(gameView)
        
        let scoreFrame = CGRect(x:20, y:20, width:self.view.frame.width, height:70)
        self.scoreLabel = UILabel(frame:scoreFrame)
        self.scoreLabel.font = self.scoreLabel.font.withSize(40)
        
        self.scoreLabel.text = "Score: "+String(self.gameView.gc.score)
        self.scoreLabel.textColor = .white
        view.addSubview(scoreLabel)
    }
    
    
    func updateScoreLabel() {
        self.scoreLabel.text = "Score: "+String(self.gameView.gc.score)
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
        updateScoreLabel()
        if gameView.gc.gameOver {
            gameLoop.invalidate()
            
            let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menu")
            self.navigationController?.pushViewController(menuController, animated: false)
        }
        
    }
    
    
    


}

