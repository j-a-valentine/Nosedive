//
//  StoreViewController.swift
//  Nosedive
//
//  Created by Bryce Capuano on 11/13/22.
//

import UIKit
import FirebaseDatabase


class StoreViewController: UIViewController {
    
    private let database = Database.database().reference()

    
    var firebasefile:FirebaseFile = FirebaseFile()
    

    @IBOutlet weak var ghostModeButton: UIButton!
    @IBOutlet weak var boostButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var coinCounter: UILabel!
    @IBOutlet weak var ghostCounter: UILabel!
    @IBOutlet weak var boostCounter: UILabel!
    @IBOutlet weak var easyCounter: UILabel!
    
    
    @IBAction func easyPressed(_ sender: Any) {
        if(UserData.totalCoins >= 15) {
            print("Easy Bought")
            UserData.easyCount += 1
            UserData.totalCoins -= 15
            firebasefile.updatePowerUps(addGhost: false, addSimple: true, addSlow: false, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)

        }

        updateText()
    }
    
    @IBAction func ghostPressed(_ sender: Any) {
        if(UserData.totalCoins >= 50) {
            print("Ghost Bought")

            UserData.ghostCount += 1
            UserData.totalCoins -= 50
            firebasefile.updatePowerUps(addGhost: true, addSimple: false, addSlow: false, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)
        }

        updateText()
    }
    
    @IBAction func boostPressed(_ sender: Any) {
        if(UserData.totalCoins >= 30) {
            print("Boost Bought")

            UserData.slowCount += 1
            UserData.totalCoins -= 30
            firebasefile.updatePowerUps(addGhost: false, addSimple: false, addSlow: true, theUsername: UserData.Username)
            firebasefile.updateCoins(newCoin: UserData.totalCoins, Username: UserData.Username)
        }
        updateText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebasefile.updatePowerUps(addGhost: false, addSimple: false, addSlow: false, theUsername: UserData.Username)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UserData.totalCoins = firebasefile.getCoins(Username: UserData.Username)
        updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func updateText() {
        getInfo(Username: UserData.Username)
        print(UserData.Username)



    }
    
    
    public func getInfo(Username: String){
        
        //var object1: AnyObject!;
        
        var highscore: AnyObject!;

        //highscore = -1;
            
            
            database.getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                  //highscore = -2;
                return;
              }
                highscore = snapshot?.value as AnyObject;
                let i = highscore.value(forKey: "\(Username)") as AnyObject
                let j = i["Coins"] as! Int
                let simple = i["SimpleModes"] as? Int ?? 0
                let ghost = i["GhostModes"] as? Int ?? 0
                let slow = i["SlowModes"] as? Int ?? 0

                UserData.totalCoins = j
                var s = ""
                s = "\(j)"
                self.coinCounter.text = "Coins: \(s)"
                self.boostCounter.text = "Owned: \(slow)"
                self.ghostCounter.text = "Owned: \(ghost)"
                self.easyCounter.text = "Owned: \(simple)"
                
                //let temp = "Coins:" + String(j)
            });
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
