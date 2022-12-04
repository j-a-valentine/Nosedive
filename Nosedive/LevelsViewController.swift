//
//  LevelsViewController.swift
//  Nosedive
//
//  Created by Jake Valentine on 11/14/22.
//

import UIKit

class LevelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var levels:[String] = ["Endless", "Back And Forth", "Long Level"]
    var levelTiles:[String : [[Int]] ] = ["Endless": [],
                                          "Back And Forth": [[3,2],[4,2],[5,2],[6,1],[5,2],[4,2],[3,2],[2,2],[1,2], [0,2],[0, 1],[0,2],[1,2],[2,2],[3,2],[4,2],[5,2],[6,1],[5,2],[4,2], [3,2],[2,2],[1,2],[0,2],[0, 1]],
                                          "Long Level": [[3, 1],[3, 2],[4, 1],[4, 1],[3, 2],[3, 1],[3, 3],[5, 1],[3, 3],[3, 1],[3, 1],[3, 1],[3, 2],[4, 1],[4, 2],[5, 1],[5, 2],[6, 1],[4, 3],[4, 1],[4, 3],[6, 1],[4, 3],[4, 1],[1, 4],[1, 1],[0, 2],[0, 1],[0, 7],[3, 4],[6, 1],[6, 1],[5, 2],[2, 5],[2, 1],[2, 1],[2, 4],[5, 1],[4, 2],[1, 5],[1, 1],[1, 6],[4, 3],[6, 1],[3, 4],[0, 7],[0, 1],[0, 5],[3, 2],[4, 1],[4, 3],[6, 1],[5, 2],[5, 1],[5, 2],[6, 1],[5, 2],[5, 1],[4, 2],[1, 5],[1, 1],[1, 4],[4, 1],[3, 2],[0, 5],[0, 1],[0, 4],[3, 1],[0, 4],[0, 1],[0, 5],[3, 2],[4, 1],[2, 3],[2, 1],[2, 2],[3, 1],[3, 2],[4, 1],[4, 1],[3, 2],[3, 1],[3, 3],[5, 1],[5, 2],[6, 1],[3, 4],[0, 7],[0, 1],[0, 6],[3, 3],[5, 1],[4, 2],[4, 1],[2, 3],[2, 1],[2, 4],[5, 1],[3, 3],[3, 1],[3, 3],[5, 1],[4, 2],[4, 1]] ]
    
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
