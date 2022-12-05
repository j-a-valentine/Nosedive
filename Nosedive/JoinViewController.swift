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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func returningUser(_ sender: Any) {
    
    }
    
    @IBAction func returningUserButton(_ sender: Any) {
        if let username = returningUserTextOutlet.text{
            getRecurringUser(Username: username)
        }
    }
    
    public func getRecurringUser(Username: String){
            
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
                    UserDefaults.standard.set("\(Username)", forKey: "curUser")
                    self.returningUserResult.text = "Successful"
                    UserData.Username = Username
                    UserData.totalCoins = b["\(Username)" as NSObject]?["Coins"] as! Int
                    UserData.HighScore = b["\(Username)" as NSObject]?["High Score"] as! Int
                }
                
            });
    }
    
    @IBOutlet weak var returningUserResult: UILabel!
    
    @IBOutlet weak var returningUserTextOutlet: UITextField!
    
    @IBAction func newUserTextAction(_ sender: Any) {
        
    }
    
    @IBAction func newUserTextOutlet(_ sender: Any) {
    }
    
    @IBOutlet weak var newUserTextOutlet2: UITextField!
    
    @IBAction func newUserButton(_ sender: Any) {
        if let username = newUserTextOutlet2.text {
            createNewUser(Username: username)
        }
    }
    
    @IBOutlet weak var newUserResult: UILabel!
    
    public func createNewUser(Username: String){
            
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
                    UserDefaults.standard.set("\(Username)", forKey: "curUser")
                    self.newUserResult.text = "Successfully Created"
                    
                    let object: [String: Any] = [
                    
                        "Coins": 0,
                        "High Score": 0,
                        "Username": s
                    ]
                    
                    self.database.child("\(Username)").setValue(object)
                    
                    UserData.Username = Username
                    UserData.totalCoins = 0
                    UserData.HighScore = 0
                }
                
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
