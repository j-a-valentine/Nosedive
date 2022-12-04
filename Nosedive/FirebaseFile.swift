//
//  FirebaseFile.swift
//  Nosedive
//
//  Created by Pranav Kotilingam on 12/2/22.
//

import Foundation

import FirebaseDatabase

public class FirebaseFile {
    
    private let database = Database.database().reference()
    
    public func addNewUser(Username: String){
        
        let object: [String: Int] = [
        
            "Coins": 25,
            "High Score": 25,
            "Random_Int": 20
        ]
        
        database.child("\(Username)").setValue(object)

    }
    
    public func updateCoins(newCoin: Int, Username: String){
      
        database.child("\(Username)/Coins").setValue(newCoin)
    }
    
    public func updateHighScore(newHighScore: Int, Username: String){
        
        database.child("\(Username)/High Score").setValue(newHighScore)
    }
    
    public func getCoins(Username: String) -> Int{
        
        var object1: AnyObject!;
        
        database.child("\(Username)").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            object1 = snapshot?.value as? AnyObject;
        });
        
        let coin = object1?["Coins"] as? Int ?? -1;
        
        print("Coins" + String(coin));
        
        return coin;
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

            });
   
        return -1;
    }
}
