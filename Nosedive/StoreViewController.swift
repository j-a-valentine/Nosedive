//
//  StoreViewController.swift
//  Nosedive
//
//  Created by Bryce Capuano on 11/13/22.
//

import UIKit

class StoreViewController: UIViewController {
    
    
    @IBOutlet weak var pA: UIButton!
    @IBOutlet weak var pB: UIButton!
    @IBOutlet weak var pC: UIButton!
    @IBOutlet weak var pD: UIButton!
    
    @IBOutlet weak var sA: UIButton!
    @IBOutlet weak var sB: UIButton!
    @IBOutlet weak var sC: UIButton!
    @IBOutlet weak var sD: UIButton!
    
    @IBAction func pA_Pressed(_ sender: Any) {
        print("pressed")
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
