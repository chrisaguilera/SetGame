//
//  LeaderboardViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    @IBOutlet weak var leaderboardSegmentedControl: UISegmentedControl!
    @IBOutlet weak var backgroundTableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var scores: [Score]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Visual Stuff
        leaderboardSegmentedControl.layer.cornerRadius = 5.0
        backgroundTableView.layer.cornerRadius = 5.0
        
        scores = loadLocalScores()
    }
    
    func loadLocalScores() -> [Score]? {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        let documentDirectoryURL = URL(fileURLWithPath: documentDirectoryPath)
        let fileURL = documentDirectoryURL.appendingPathComponent("scores.plist")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let jsonDecoder = JSONDecoder()
                let jsonData = try Data(contentsOf: fileURL)
                return try jsonDecoder.decode([Score].self, from: jsonData).sorted(by: { (lhs, rhs) -> Bool in
                    if lhs.score > rhs.score {
                        return true
                    }
                    if lhs.score == rhs.score {
                        if lhs.date.timeIntervalSince(rhs.date) > 0 {
                            return true
                        }
                    }
                    return false
                })
            } catch {
                print(error)
            }
        }
        return [Score]()
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            scores = loadLocalScores()
        } else {
            scores = [Score]()
        }
        tableView.reloadData()
    }
}

extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return scores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Personal Leaderboard Cell") as! PersonalLeaderboardTableViewCell
        cell.score = scores?[indexPath.section]
        cell.updateTableViewCell()
        cell.rankLabel.text = String(indexPath.section + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
