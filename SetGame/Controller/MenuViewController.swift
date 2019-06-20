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
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loggedInIndicatorLabel: UILabel!
    
    var newGameHandler: (() -> Void)?
    
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
        logOutButton.layer.cornerRadius = 5.0
        usernameView.layer.cornerRadius = 5.0
        
        if let username = UserDefaults.standard.string(forKey: "Username") {
            setupLoggedIn(username: username)
        } else {
            setupLoggedOut()
        }
    }
    
    @IBAction func backgroundButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        newGameHandler?()
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        setupLoggedOut()
    }
    
    func setupLoggedOut() {
        UserDefaults.standard.removeObject(forKey: "Username")
        signInButton.isHidden = false
        signUpButton.isHidden = false
        logOutButton.isHidden = true
        usernameView.isHidden = true
    }
    
    func setupLoggedIn(username: String) {
        signInButton.isHidden = true
        signUpButton.isHidden = true
        logOutButton.isHidden = false
        usernameLabel.text = username
        usernameView.isHidden = false
    }
}
