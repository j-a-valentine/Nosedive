//
//  MenuViewController.swift
//  Nosedive
//
//  Created by Jeff Candell on 11/10/22.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    @IBAction func playButtonPress(_ sender: UIButton) {
        let gameController = GameViewController()
        self.navigationController?.pushViewController(gameController, animated: false)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
