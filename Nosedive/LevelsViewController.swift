//
//  LevelsViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/14/22.
//

import UIKit

class LevelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var levels:[String] = ["Endless", "Level 1", "Level 2"]
    var levelTiles:[String : [[Int]] ] = ["Endless": [], "Level 1": [[3,2],[4,1],[4,1]], "Level 2": [[2,2],[2,1],[1,2],[1,1]]  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "levelCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "levelCell")
        cell.textLabel?.text = levels[indexPath.row]
        cell.backgroundColor = .systemCyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tileData = levelTiles[levels[indexPath.row]] ?? []
        let gameViewController = GameViewController()
        gameViewController.tileData = tileData
        self.navigationController?.pushViewController(gameViewController, animated: false)
    }
    

    

}
