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
        gCount += 1
        ghostCounter.text = "Owned: \(gCount)"
    }
    
    @IBAction func boostPressed(_ sender: Any) {
        bCount += 1
        boostCounter.text = "Owned: \(bCount)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        coinCounter.text = "Coins: \(UserData.totalCoins)"
        
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
