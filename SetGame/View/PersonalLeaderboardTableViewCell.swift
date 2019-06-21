//
//  PersonalLeaderboardTableViewCell.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/21/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class PersonalLeaderboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeSinceLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    var score: Score?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5.0
    }
    
    func updateTableViewCell() {
        if let score = score {
            scoreLabel.text = String(score.score)
            usernameLabel.text = score.user
            timeSinceLabel.text = Date().timeIntervalSince(score.date).stringForTimeInterval()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TimeInterval {
    func stringForTimeInterval() -> String {
        let kMinute: Double = 60
        let kHour: Double = 3600
        let kDay: Double = 86400
        let kMonth: Double = 2592000
        let kYear: Double = 31104000
        
        if self < kMinute {
            return "\(Int(self)) secs ago"
        } else if self < kHour {
            let minutes = Int(self/kMinute)
            return "\(minutes) mins ago"
        } else if self < kDay {
            let hours = Int(self/kHour)
            return "\(hours) hrs ago"
        } else if self < kMonth {
            let days = Int(self/kDay)
            return "\(days) days ago"
        } else if self < kYear {
            let months = Int(self/kMonth)
            return "\(months) mos ago"
        } else {
            let years = Int(self/kYear)
            return "\(years) yrs ago"
        }
    }
}

