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
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
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
        
        if navigationController == nil {
            let height: CGFloat = 75
            let statusBarHeight = UIApplication.shared.statusBarFrame.height;
            let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
            navbar.barTintColor = AppConstants.mainBackgroundColor
            navbar.isTranslucent = false
            navbar.tintColor = UIColor.white
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium)
            ]
            navbar.titleTextAttributes = attrs
            navbar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navbar.delegate = self as? UINavigationBarDelegate
            
            let navItem = UINavigationItem()
            navItem.title = "Sign In"
            let backButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(barCancelButtonPressed))
            navItem.leftBarButtonItem = backButton
            navbar.items = [navItem]
            
            view.addSubview(navbar)
            topConstraint.constant = AppConstants.topConstraint
        }
    }
    
    @objc func barCancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        view.endEditing(true)
        if usernameTextField.text?.count ?? 0 > 0, passwordTextField.text?.count ?? 0 > 0, let username = usernameTextField.text, let password = passwordTextField.text {
            
            // TODO: Encrypt password before sending to server
            
            let userSignIn = User(username: username, password: password, scores: [])
            ServerManager.attemptSignIn(user: userSignIn) { user in
                UserDefaults.standard.set(userSignIn.username, forKey: "Username")
                if self.navigationController != nil {
                    let vc: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    if let menuVC = self.presentingViewController as? MenuViewController {
                        menuVC.setupLoggedIn(username: userSignIn.username)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
