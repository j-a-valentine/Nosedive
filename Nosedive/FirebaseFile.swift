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
            "Random_Int": 20,
            "GhostModes": 0,
            "SimpleModes": 0,
            "SlowModes": 0
        ]
        
        database.child("\(Username)").setValue(object)

    }
    
    public func updateCoins(newCoin: Int, Username: String){
      
        database.child("\(Username)/Coins").setValue(newCoin)
    }
    
    public func updateHighScore(newHighScore: Int, Username: String){
        
        database.child("\(Username)/High Score").setValue(newHighScore)
    }
    
    public func updatePowerUps(addGhost: Int, addSimple: Int, addSlow: Int, theUsername: String){
        
        let ghostTotal = addGhost + getPowerUps(Username: theUsername)[0]
        let simpleTotal = addSlow + getPowerUps(Username: theUsername)[1]
        let slowTotal = addSlow + getPowerUps(Username: theUsername)[2]

        
        database.child("\(theUsername)/GhostModes").setValue(ghostTotal)
        database.child("\(theUsername)/SimpleModes").setValue(simpleTotal)
        database.child("\(theUsername)/SlowModes").setValue(slowTotal)
    }
    
    public func getPowerUps(Username: String) -> Array<Int>{
        
        var object1: AnyObject!;
        var powerArr: [Int] = [3]
        
        database.child("\(Username)").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            object1 = snapshot?.value as? AnyObject;
        });
        
        powerArr.append(object1?["GhostModes"] as? Int ?? -1);
        powerArr.append(object1?["SimpleModes"] as? Int ?? -1);
        powerArr.append(object1?["SlowModes"] as? Int ?? -1);

        return powerArr;
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
        
        let coin = object1?["Coins"] as? Int ?? 0;
        
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
