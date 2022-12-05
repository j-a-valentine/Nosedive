//
//  PostGameViewController.swift
//  Nosedive
//
//  Created by Sproull Student on 12/4/22.
//

import UIKit

class PostGameViewController: UIViewController {
    
    var firebasefile:FirebaseFile = FirebaseFile()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    var didWin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.showScore()
        self.setTitle()
        firebasefile.updatePowerUps(addGhost: false, addSimple: false, addSlow: false, theUsername: UserData.Username)
    }
    
    func showScore(){
        self.scoreLabel.text="Score: \(self.score)"
    }
    
    func setTitle(){
        if didWin{
            titleLabel.text="You Win!"
        }else{
            titleLabel.text="Game Over"
        }
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menu")
        self.navigationController?.pushViewController(menuController, animated: true)
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        let levelController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "levels")
        self.navigationController?.pushViewController(levelController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
