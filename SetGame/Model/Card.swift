//
//  Card.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/3/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible, Equatable {
    
    var description: String {
        return "\(numShapes)\(shape)\(shading)\(color)"
    }
    
    static func ==(rhs: Card, lhs: Card) -> Bool {
        return rhs.numShapes == lhs.numShapes && rhs.shape == lhs.shape && rhs.shading == lhs.shading && rhs.color == lhs.color
    }
    
    let numShapes: NumberOfShapes
    let shape: Shape
    let shading: Shading
    let color: Color
    
    enum NumberOfShapes: Int, CustomStringConvertible {
        
        var description: String {
            switch self {
            case .one:
                return "1"
            case .two:
                return "2"
            case .three:
                return "3"
            }
        }
        
        case one = 1
        case two = 2
        case three = 3
        
        static var all: [NumberOfShapes] {
            return [.one, .two, .three]
        }
    }
    
    enum Shape: CustomStringConvertible {
        
        var description: String {
            switch self {
            case .first:
                return "Tr"
            case .second:
                return "Ci"
            case .third:
                return "Sq"
            }
        }
        
        case first
        case second
        case third
        
        static var all: [Shape] {
            return [.first, .second, .third]
        }
    }
    
    enum  Shading: CustomStringConvertible {
        
        var description: String {
            switch self {
            case .first:
                return "So"
            case .second:
                return "St"
            case .third:
                return "Ot"
            }
        }
        case first
        case second
        case third
        
        static var all: [Shading] {
            return [.first, .second, .third]
        }
    }
    
    enum Color: CustomStringConvertible {
        
        var description: String {
            switch self {
            case .first:
                return "Re"
            case .second:
                return "Bl"
            case .third:
                return "Gr"
            }
        }
        
        case first
        case second
        case third
        
        static var all: [Color] {
            return [.first, .second, .third]
        }
    }
}
