//
//  ThemesViewController.swift
//  Nosedive
//
//  Created by Sproull Student on 11/10/22.
//

import UIKit

class ThemesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let userDefaults = UserDefaults.standard
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = themesCollectionView.dequeueReusableCell(withReuseIdentifier: "themeCell", for: indexPath)

        guard let cell = cell as? ThemeCell
        else{
            return UICollectionViewCell()
        }
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.image = UIImage(named: themeImageNames[indexPath.row])
        cell.theme.text = themes[indexPath.row]
        if indexPath.row == userDefaults.integer(forKey: "theme") {
            cell.backgroundColor = .systemBlue
        }
        else {
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userDefaults.set(indexPath.row, forKey: "theme")
        themesCollectionView.reloadData()
    }
    
    
    var themes = ["Fire", "Water","Earth", "Space"]
    var themeImageNames = ["fire_player", "water_player", "earth_player", "space_player"]
    
    @IBOutlet weak var themesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themesCollectionView.dataSource = self
        themesCollectionView.delegate = self
        themesCollectionView.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
