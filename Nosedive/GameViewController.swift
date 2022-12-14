//
//  ViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/2/22.
//

import UIKit
import FirebaseDatabase


class GameViewController: UIViewController {

    var gameView:GameView!
    var scoreLabel:UILabel!
    var ghostButton:UIButton!
    var slowButton:UIButton!
    var simpleButton:UIButton!
    var gameLoop:Timer!
    var tileData:[[Int]]!
    var themes:[Theme] = []
    var theme:Theme!
    let userDefaults = UserDefaults.standard
    
    var hasGhost:Bool! = true
    var hasSimple:Bool! = true
    var hasSlow:Bool! = true

    var firebasefile:FirebaseFile = FirebaseFile()
    private let database = Database.database().reference()

    
    
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
        themes.append(Theme(pathColor: .white, barrierColor: .red, goalColor:.orange, playerImage: UIImage(named: "fire_player")!))
        themes.append(Theme(pathColor: .blue, barrierColor: .white, goalColor:.systemBlue, playerImage: UIImage(named: "water_player")!))
        themes.append(Theme(pathColor: UIColor(red: 135/255, green: 200/255, blue: 235/255, alpha: 1), barrierColor: .green, goalColor:.systemGreen, playerImage: UIImage(named: "earth_player")!))
        themes.append(Theme(pathColor: .white, barrierColor: .black, goalColor:.lightGray, playerImage: UIImage(named: "space_player")!))
    }
    
    func selectTheme() {
        self.theme = themes[userDefaults.integer(forKey: "theme")]
    }
    
    func setGameView() {
        getInfo(Username: UserData.Username)
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
        
        if hasGhost {
            let ghostButtonFrame = CGRect(x:40,y:720, width:80, height:40)
            self.ghostButton = UIButton(frame: ghostButtonFrame)
            self.ghostButton.setTitle("Ghost", for: .normal)
            if self.theme.barrierColor == .black{
                self.ghostButton.backgroundColor = .red
            }else{
                self.ghostButton.backgroundColor = .black
            }
            self.ghostButton.setTitleColor(.white, for: .normal)
            self.ghostButton.addTarget(self, action: #selector(activateGhost), for: .touchUpInside)
            view.addSubview(self.ghostButton)
        }
        
        if hasSlow {
            let slowButtonFrame = CGRect(x:160,y:720, width:80, height:40)
            self.slowButton = UIButton(frame: slowButtonFrame)
            self.slowButton.setTitle("Slow", for: .normal)
            if self.theme.barrierColor == .black{
                self.slowButton.backgroundColor = .red
            }else{
                self.slowButton.backgroundColor = .black
            }
            self.slowButton.setTitleColor(.white, for: .normal)
            self.slowButton.addTarget(self, action: #selector(activateSlow), for: .touchUpInside)
            view.addSubview(self.slowButton)
        }
        if self.tileData.count != 0{
            hasSimple = false
        }
        if hasSimple {
            print("getting to has simple")
            let simpleButtonFrame = CGRect(x:280,y:720, width:80, height:40)
            self.simpleButton = UIButton(frame: simpleButtonFrame)
            self.simpleButton.setTitle("Simple", for: .normal)
            if self.theme.barrierColor == .black{
                self.simpleButton.backgroundColor = .red
            }else{
                self.simpleButton.backgroundColor = .black
            }
            self.simpleButton.setTitleColor(.white, for: .normal)
            self.simpleButton.addTarget(self, action: #selector(activateSimple), for: .touchUpInside)
            view.addSubview(self.simpleButton)
        }
    }
    
    @objc func activateGhost() {
        self.gameView.gc.activateGhost()
        self.ghostButton.backgroundColor = .clear
        self.ghostButton.setTitle("", for: .normal)
    }
    
    @objc func activateSlow() {
        self.gameView.gc.activateSlow()
        self.slowButton.backgroundColor = .clear
        self.slowButton.setTitle("", for: .normal)
    }
    
    @objc func activateSimple() {
        self.gameView.gc.activateSimple()
        self.simpleButton.backgroundColor = .clear
        self.simpleButton.setTitle("", for: .normal)
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
            if tileData.count == 0{
                updateHighScore(score: gameView.gc.score)
            }
            
            
            UserData.totalCoins += self.gameView.gc.score
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)
            let postGameController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "postgame")
            guard let postGameController = postGameController as? PostGameViewController else {return}
            postGameController.score = self.gameView.gc.score
            postGameController.didWin=self.gameView.gc.didWin
            self.navigationController?.pushViewController(postGameController, animated: false)
        }
        
    }
    
    func updateHighScore(score:Int) {
        //if score > {current score in database}
            //put score in database
        if(score > UserData.HighScore){
            UserData.HighScore = score
            firebasefile.updateHighScore(newHighScore: UserData.HighScore, Username: UserData.Username)
        }
    }
    
    
    public func getInfo(Username: String){

        if(UserData.easyCount <= 0) { self.hasSimple = false }
        if(UserData.ghostCount <= 0) { self.hasGhost = false}
        if(UserData.slowCount <= 0) { self.hasSlow = false}

                
                //let temp = "Coins:" + String(j)
    }
    
    
    


}

