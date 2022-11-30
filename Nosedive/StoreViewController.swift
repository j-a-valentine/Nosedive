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
    
    @IBOutlet weak var coinCounter: UILabel!
    @IBOutlet weak var ghostCounter: UILabel!
    @IBOutlet weak var boostCounter: UILabel!
    // GRAB FROM CORE DATA
    var gCount = 0
    var bCount = 0
    
    
    @IBAction func ghostPressed(_ sender: Any) {
        if(UserData.totalCoins > 20) {
            gCount += 1
            UserData.totalCoins -= 20
        }
        updateText()
    }
    
    @IBAction func boostPressed(_ sender: Any) {
        if(UserData.totalCoins > 20) {
            bCount += 1
            UserData.totalCoins -= 20
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
        boostCounter.text = "Owned: \(bCount)"
        ghostCounter.text = "Owned: \(gCount)"


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
