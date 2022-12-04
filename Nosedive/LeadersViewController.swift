//
//  LeadersViewController.swift
//  Nosedive
//
//  Created by Sproull Student on 11/10/22.
//

import UIKit
import FirebaseDatabase

class LeadersViewController: UIViewController {
    
    var firebasefile:FirebaseFile = FirebaseFile()

    @IBOutlet weak var Username1: UILabel!
    
    @IBOutlet weak var Score1: UILabel!
    
    @IBOutlet weak var Username2: UILabel!
    
    @IBOutlet weak var Score2: UILabel!
    
    @IBOutlet weak var Username3: UILabel!
    
    @IBOutlet weak var Score3: UILabel!
    
    @IBOutlet weak var Username4: UILabel!
    
    @IBOutlet weak var Score4: UILabel!
    
    @IBOutlet weak var Username5: UILabel!
    
    @IBOutlet weak var Score5: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Do any additional setup after loading the view.
        //firebasefile.addNewUser(Username: "User2")
        //firebasefile.updateCoins(newCoin: 50)
        //firebasefile.updateHighScore(newHighScore: 50)
        //let i = firebasefile.getCoins()
        //let j = firebasefile.getHighScore()
       // print("HighScore = " + String(j))
        getTopScores()
        
    }
    
    private let database = Database.database().reference()
    
    public func getTopScores() -> Int{
        
        
        //var highscore: AnyObject!;
            
            database.getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                  //highscore = -2;
                return;
              }
                //highscore = snapshot?.value as AnyObject;
                
                let a = snapshot?.value as! NSDictionary
    
                let b = a as Dictionary
          
                let values_array = b.values
                
                let sorted_array = values_array.sorted(by: {$0["High Score"] as! Int > $1["High Score"] as! Int})
                
                let arraySlice = sorted_array[0...4]
                
                var counter = 1
                
                for hs in arraySlice{
                    //print("High Score: " + hs["High Score"])
                    let v = hs["High Score"] as! Int
                    let high_score = String(v)
                    print("High Score = \(high_score)")
                    
                    let user = hs["Username"] as! String
                    print("User = \(user)")
                    
                    if(counter == 1){
                        self.Username1.text = user
                        self.Score1.text = high_score
                    }
                    if(counter == 2){
                        self.Username2.text = user
                        self.Score2.text = high_score
                    }
                    if(counter == 3){
                        self.Username3.text = user
                        self.Score3.text = high_score
                    }
                    if(counter == 4){
                        self.Username4.text = user
                        self.Score4.text = high_score
                    }
                    if(counter == 5){
                        self.Username5.text = user
                        self.Score5.text = high_score
                    }
                    counter += 1
                }
                
            });
   
        return -1;
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
