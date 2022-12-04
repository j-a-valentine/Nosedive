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
