//
//  User.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/19/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    var scores: [Score]
}
