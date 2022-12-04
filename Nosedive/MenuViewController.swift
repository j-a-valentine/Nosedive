//
//  MenuViewController.swift
//  Nosedive
//
//  Created by Jeff Candell on 11/10/22.
//

import UIKit
import FirebaseDatabase

class MenuViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var coinLabel: UILabel!
    let userDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var printingName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserData.totalCoins =
        //UserData.HighScore =
        //coinLabel.text = "Coins: \(UserData.totalCoins)"
        
        let object: [String: Int] = [
        
            "Coins": 0,
            "High Score": 0,
            "Random_Int": 0
        ]
        
        database.child("Default_User").setValue(object)
        
        getCoins(Username: "\(UserData.Username)")
        getHighScore(Username: "\(UserData.Username)")
        printingName.text = "\(UserData.Username)!"
        // Do any additional setup after loading the view.
    }
    
    public func getCoins(Username: String) -> Int{
        
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
                UserData.totalCoins = j
                var s = ""
                s = "\(j)"
                self.coinLabel.text = "Coins: \(s)"
                //let temp = "Coins:" + String(j)
            });
   
        return -1;
    }
    
    public func getHighScore(Username: String) -> Int{
        
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
                let j = i["High Score"] as! Int
                UserData.HighScore = j
                var s = ""
                s = "\(j)"
                //self.coinLabel.text = "Coins: \(s)"
                //let temp = "Coins:" + String(j)
            });
   
        return -1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getCoins(Username: "\(UserData.Username)")
        printingName.text = "\(UserData.Username)!"
    }
    

    @IBAction func playButtonPress(_ sender: UIButton) {
        guard let levelController = self.storyboard?.instantiateViewController(withIdentifier: "levels") else{return}
        self.navigationController?.pushViewController(levelController, animated: true)
    }
    
    @IBAction func themeButtonPress(_ sender: UIButton) {
        guard let themeController = self.storyboard?.instantiateViewController(withIdentifier: "themes") else{return}
        self.navigationController?.pushViewController(themeController, animated: true)
    }
    
    @IBAction func leaderboardButtonPress(_ sender: UIButton) {
        guard let themeController = self.storyboard?.instantiateViewController(withIdentifier: "leaders") else{return}
        self.navigationController?.pushViewController(themeController, animated: true)
    }
    
    @IBAction func storeButtonPress(_ sender: Any) {
        
        guard let storeController = self.storyboard?.instantiateViewController(withIdentifier: "store") else{return}
        self.navigationController?.pushViewController(storeController, animated: true)
        
    }
    
    @IBAction func joinButtonPress(_ sender: Any) {
        guard let themeController = self.storyboard?.instantiateViewController(withIdentifier: "join") else{return}
        self.navigationController?.pushViewController(themeController, animated: true)
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
