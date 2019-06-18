//
//  SignInViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var noAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Visual Stuff
        usernameTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.cornerRadius = 5.0
        signInButton.layer.cornerRadius = 5.0
        cancelButton.layer.cornerRadius = 5.0
        if navigationController == nil {
            cancelButton.isHidden = false
        } else {
            cancelButton.isHidden = true
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
