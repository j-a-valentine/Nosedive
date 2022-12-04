//
//  JoinViewController.swift
//  Nosedive
//
//  Created by Pranav Kotilingam on 12/3/22.
//

import UIKit
import FirebaseDatabase

class JoinViewController: UIViewController {
    
    private let database = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returningUser(_ sender: Any) {
    
    }
    
    @IBAction func returningUserButton(_ sender: Any) {
        var entered_Username = returningUserTextOutlet.text
        var username2 = entered_Username!
        getRecurringUser(Username: username2)
    }
    
    public func getRecurringUser(Username: String) -> Int{
        
        var highscore: AnyObject;
            
            database.getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
                //highscore = snapshot?.value as AnyObject;
                
                let a = snapshot?.value as! NSDictionary
    
                let b = a as Dictionary
                
                var s = ""
                s = "\(Username)"
                
                if(b["\(s)" as NSObject] == nil){
                    self.returningUserResult.text = "User not Found"
                } else{
                    self.returningUserResult.text = "Successful"
                    UserData.Username = Username
                    UserData.totalCoins = b["\(Username)" as NSObject]?["Coins"] as! Int
                    UserData.HighScore = 0
                }
                
            });
   
        return -1;
    }
    
    @IBOutlet weak var returningUserResult: UILabel!
    
    @IBOutlet weak var returningUserTextOutlet: UITextField!
    
    @IBAction func newUserTextAction(_ sender: Any) {
        
    }
    
    @IBAction func newUserTextOutlet(_ sender: Any) {
    }
    
    @IBOutlet weak var newUserTextOutlet2: UITextField!
    
    @IBAction func newUserButton(_ sender: Any) {
        var entered_Username = newUserTextOutlet2.text
        var username2 = entered_Username!
        createNewUser(Username: username2)
    }
    
    @IBOutlet weak var newUserResult: UILabel!
    
    public func createNewUser(Username: String) -> Int{
            
            database.getData(completion:  { error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
                
                let a = snapshot?.value as! NSDictionary
    
                let b = a as Dictionary
                
                var s = ""
                s = "\(Username)"
                
                if(b["\(s)" as NSObject] != nil){
                    self.newUserResult.text = "Username Already Exists"
                } else{
                    self.newUserResult.text = "Successfully Created"
                    
                    let object: [String: Int] = [
                    
                        "Coins": 0,
                        "High Score": 0,
                    ]
                    
                    self.database.child("\(Username)").setValue(object)
                    
                    UserData.Username = Username
                    UserData.totalCoins = 0
                    UserData.HighScore = 0
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
