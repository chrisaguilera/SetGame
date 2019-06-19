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
            navbar.items = [navItem]
            
            view.addSubview(navbar)
            topConstraint.constant = AppConstants.topConstraint
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
