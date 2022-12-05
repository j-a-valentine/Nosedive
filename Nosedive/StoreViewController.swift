//
//  StoreViewController.swift
//  Nosedive
//
//  Created by Bryce Capuano on 11/13/22.
//

import UIKit

class StoreViewController: UIViewController {
    
    var firebasefile:FirebaseFile = FirebaseFile()
    

    @IBOutlet weak var ghostModeButton: UIButton!
    @IBOutlet weak var boostButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var coinCounter: UILabel!
    @IBOutlet weak var ghostCounter: UILabel!
    @IBOutlet weak var boostCounter: UILabel!
    @IBOutlet weak var easyCounter: UILabel!
    
    
    @IBAction func easyPressed(_ sender: Any) {
        if(UserData.totalCoins > 15) {
            UserData.easyCount += 1
            UserData.totalCoins -= 15
            firebasefile.updatePowerUps(addGhost: 0, addSimple: 1, addSlow: 0, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)

        }

        updateText()
    }
    
    @IBAction func ghostPressed(_ sender: Any) {
        if(UserData.totalCoins > 30) {
            UserData.ghostCount += 1
            UserData.totalCoins -= 30
            firebasefile.updatePowerUps(addGhost: 1, addSimple: 0, addSlow: 0, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)
        }

        updateText()
    }
    
    @IBAction func boostPressed(_ sender: Any) {
        if(UserData.totalCoins > 50) {
            UserData.slowCount += 1
            UserData.totalCoins -= 50
            firebasefile.updatePowerUps(addGhost: 0, addSimple: 0, addSlow: 1, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)
        }
        updateText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebasefile.updatePowerUps(addGhost: 0, addSimple: 0, addSlow: 0, theUsername: UserData.Username)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UserData.totalCoins = firebasefile.getCoins(Username: UserData.Username) + 1000
        updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func updateText() {
        firebasefile.updateCoins(newCoin: 0, Username: UserData.Username)
        let powerArr = firebasefile.getPowerUps(Username: UserData.Username)
        coinCounter.text = "Coins: \(UserData.totalCoins)"
        boostCounter.text = "Owned: \(powerArr[2])"
        ghostCounter.text = "Owned: \(powerArr[0])"
        easyCounter.text = "Owned: \(powerArr[1])"


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
