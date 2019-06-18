//
//  MenuViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Visual Stuff
        popupView.layer.cornerRadius = 5.0
        newGameButton.layer.cornerRadius = 5.0
        leaderboardButton.layer.cornerRadius = 5.0
        howToPlayButton.layer.cornerRadius = 5.0
        rateButton.layer.cornerRadius = 5.0
        signUpButton.layer.cornerRadius = 5.0
        signInButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func backgroundButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
