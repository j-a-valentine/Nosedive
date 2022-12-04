//
//  StoreViewController.swift
//  Nosedive
//
//  Created by Bryce Capuano on 11/13/22.
//

import UIKit

class StoreViewController: UIViewController {
    

    @IBOutlet weak var ghostModeButton: UIButton!
    @IBOutlet weak var boostButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var coinCounter: UILabel!
    @IBOutlet weak var ghostCounter: UILabel!
    @IBOutlet weak var boostCounter: UILabel!
    @IBOutlet weak var easyCounter: UILabel!
    // GRAB FROM CORE DATA
    
    
    @IBAction func easyPressed(_ sender: Any) {
        if(UserData.totalCoins > 15) {
            UserData.easyCount += 1
            UserData.totalCoins -= 15
        }
        updateText()
    }
    
    @IBAction func ghostPressed(_ sender: Any) {
        if(UserData.totalCoins > 30) {
            UserData.ghostCount += 1
            UserData.totalCoins -= 30
        }
        updateText()
    }
    
    @IBAction func boostPressed(_ sender: Any) {
        if(UserData.totalCoins > 50) {
            UserData.slowCount += 1
            UserData.totalCoins -= 50
        }
        updateText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        updateText()
    }
    func updateText() {
        coinCounter.text = "Coins: \(UserData.totalCoins)"
        boostCounter.text = "Owned: \(UserData.slowCount)"
        ghostCounter.text = "Owned: \(UserData.ghostCount)"
        easyCounter.text = "Owned: \(UserData.easyCount)"


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
