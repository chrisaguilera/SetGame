//
//  ReplaceSegue.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/18/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class ReplaceSegue: UIStoryboardSegue {

    override func perform() {
        if let navigationController = source.navigationController {
            navigationController.popViewController(animated: false)
            navigationController.pushViewController(destination, animated: false)
        } else {
            let presentingViewController = source.presentingViewController
            presentingViewController?.dismiss(animated: true, completion: nil)
            presentingViewController?.present(self.destination, animated: true, completion: nil)
        }
    }
}
