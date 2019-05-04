//
//  Set.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/3/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import Foundation

struct Set {
    private(set) var deck = [Card]()
    private(set) var visibleCards = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    private(set) var hiddenCards = [Card]()
    private(set) var score = 0
    
    init() {
        // Setup deck of cards
        for numShapes in Card.NumberOfShapes.all {
            for shape in Card.Shape.all {
                for shading in Card.Shading.all {
                    for color in Card.Color.all {
                        deck.append(Card(numShapes: numShapes, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        // Setup initial 12 visible cards and 12 hidden cards
        for i in 0..<24 {
            let card = deck.remove(at: deck.count.arc4random)
            visibleCards.append(card)
            if i > 11 {
                hiddenCards.append(card)
            }
        }
        
    }
    
    mutating func select(card: Card) {
        if selectedCards.count == 3 {
            matchSet()
            if matchedCards.contains(card) {
                selectedCards = [Card]()
            } else {
                selectedCards = [Card]()
                selectedCards.append(card)
            }
        } else {
            if selectedCards.count != 0, let index = selectedCards.firstIndex(of: card) { // Selected previously selected card -- deselect
                selectedCards.remove(at: index)
            } else {
                selectedCards.append(card)
            }
        }
    }
    
    mutating func dealThreeCards() {
        // Perform as set check
        if selectedCards.count == 3 {
            if validNumShapes() && validShapes() && validColors() && validShading() {
                validSet()
                matchedCards += selectedCards
                // Replace matched cards
                if deck.count > 2 {
                    for card in selectedCards {
                        if let index = visibleCards.firstIndex(of: card) {
                            visibleCards[index] = deck.remove(at: deck.count.arc4random)
                        }
                    }
                }
                selectedCards = [Card]()
            } else {
                invalidSet()
                if hiddenCards.count > 0 {
                    for _ in 0...2 {
                        hiddenCards.remove(at: 0)
                    }
                }
                selectedCards = [Card]()
            }
        } else { // Reveal hidden cards
            if hiddenCards.count > 0 {
                for _ in 0...2 {
                    hiddenCards.remove(at: 0)
                }
            }
        }
    }
    
    private mutating func matchSet() {
        if validNumShapes() && validShapes() && validColors() && validShading() {
            validSet()
            matchedCards += selectedCards
            // Replace matched cards
            if deck.count > 2 {
                for card in selectedCards {
                    if let index = visibleCards.firstIndex(of: card) {
                        visibleCards[index] = deck.remove(at: deck.count.arc4random)
                    }
                }
            }
        } else {
            invalidSet()
        }
    }
    
    private mutating func validSet() {
        score += 3
    }
    
    private mutating func invalidSet() {
        score -= 5
    }
    
    private func validNumShapes() -> Bool {
        if (selectedCards[0].numShapes == selectedCards[1].numShapes && selectedCards[1].numShapes == selectedCards[2].numShapes && selectedCards[0].numShapes == selectedCards[2].numShapes) || (selectedCards[0].numShapes != selectedCards[1].numShapes && selectedCards[1].numShapes != selectedCards[2].numShapes && selectedCards[0].numShapes != selectedCards[2].numShapes) {
            return true
        }
        return false
    }
    
    private func validShapes() -> Bool {
        if (selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape && selectedCards[0].shape == selectedCards[2].shape) || (selectedCards[0].shape != selectedCards[1].shape && selectedCards[1].shape != selectedCards[2].shape && selectedCards[0].shape != selectedCards[2].shape) {
            return true
        }
        return false
    }
    
    private func validShading() -> Bool {
        if (selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading && selectedCards[0].shading == selectedCards[2].shading) || (selectedCards[0].shading != selectedCards[1].shading && selectedCards[1].shading != selectedCards[2].shading && selectedCards[0].shading != selectedCards[2].shading) {
            return true
        }
        return false
    }
    
    private func validColors() -> Bool {
        if (selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color && selectedCards[0].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[0].color != selectedCards[2].color) {
            return true
        }
        return false
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
