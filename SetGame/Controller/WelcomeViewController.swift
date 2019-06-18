//
//  WelcomeViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Visual Stuff
        signUpButton.layer.cornerRadius = 5.0
        signInButton.layer.cornerRadius = 5.0
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
