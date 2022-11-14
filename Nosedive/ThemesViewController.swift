//
//  ThemesViewController.swift
//  Nosedive
//
//  Created by Sproull Student on 11/10/22.
//

import UIKit

class ThemesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
        cell.imageView.image = UIImage(named: themes[indexPath.row])
        cell.theme.text = themes[indexPath.row]
        return cell
    }
    
    
    var themes = ["Fire", "Water","Earth", "Space"]
    
    @IBOutlet weak var themesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        themesCollectionView.dataSource = self
        themesCollectionView.delegate = self
        themesCollectionView.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
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
