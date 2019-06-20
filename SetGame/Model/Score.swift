//
//  Score.swift
//  SetGame
//
//  Created by Chris Aguilera on 6/19/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import Foundation

struct Score: Codable {
    let user: String
    let score: Int
    let date: Date
}
