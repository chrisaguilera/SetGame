//
//  SignUpViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Visual Stuff
        usernameTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.cornerRadius = 5.0
        confirmPasswordTextField.layer.cornerRadius = 5.0
        signUpButton.layer.cornerRadius = 5.0
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
            navItem.title = "Sign Up"
            let backButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(barCancelButtonPressed))
            navItem.leftBarButtonItem = backButton
            navbar.items = [navItem]
            
            view.addSubview(navbar)
            topConstraint.constant = AppConstants.topConstraint
        }
    }
    
    @objc func barCancelButtonPressed() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        print("Sign Up Button Pressed")
        view.endEditing(true)
        if usernameTextField.text?.count ?? 0 > 0, passwordTextField.text?.count ?? 0 > 0, confirmPasswordTextField.text?.count ?? 0 > 0, let username = usernameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, password == confirmPassword {
            
            // TODO: Encrypt password before sending to server
            print("Valid credentials")
            
            let newUser = User(username: username, password: password, scores: [])
            ServerManager.postUser(newUser) { user in
                print("Completion Handler")
                UserDefaults.standard.set(newUser.username, forKey: "Username")
                if self.navigationController != nil {
                    let vc: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    if let menuVC = self.presentingViewController as? MenuViewController {
                        menuVC.setupLoggedIn(username: newUser.username)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
