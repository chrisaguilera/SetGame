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
    private(set) var score = 0
    private var prevBestScore: Int {
        return UserDefaults.standard.integer(forKey: "bestScore")
    }
    lazy var currBestScore = self.prevBestScore
    private var fileURL: URL
    var scores = [Score]()
    
    init() {
        // Local scores
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        let documentDirectoryURL = URL(fileURLWithPath: documentDirectoryPath)
        fileURL = documentDirectoryURL.appendingPathComponent("scores.plist")
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let jsonDecoder = JSONDecoder()
                let jsonData = try Data(contentsOf: fileURL)
                scores = try jsonDecoder.decode([Score].self, from: jsonData)
            } catch {
                print(error)
            }
        } else {
            print("'scores.plist' not yet created.")
        }
        
        // Configure game
        configureNewGame()
    }
    
    mutating func configureNewGame() {
        deck = [Card]()
        visibleCards = [Card]()
        selectedCards = [Card]()
        matchedCards = [Card]()
        score = 0
        for numShapes in Card.NumberOfShapes.all {
            for shape in Card.Shape.all {
                for shading in Card.Shading.all {
                    for color in Card.Color.all {
                        deck.append(Card(numShapes: numShapes, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        for _ in 0..<12 {
            visibleCards.append(deck.remove(at: deck.count.arc4random))
        }
    }
    
    mutating func select(card: Card) {
        if selectedCards.count == 3 {
            matchSet()
        } else {
            if selectedCards.count != 0, let index = selectedCards.firstIndex(of: card) {
                selectedCards.remove(at: index)
            } else {
                selectedCards.append(card)
            }
        }
    }
    
    mutating func dealThreeCards() {
        if selectedCards.count == 3 {
            let preNumMatchedCards = matchedCards.count
            matchSet()
            if matchedCards.count == preNumMatchedCards {
                if deck.count > 0 {
                    for _ in 0..<3 {
                        visibleCards.append(deck.remove(at: deck.count.arc4random))
                    }
                }
            }
        } else {
            if deck.count > 0 {
                for _ in 0..<3 {
                    visibleCards.append(deck.remove(at: deck.count.arc4random))
                }
            }
        }

    }
    
    private mutating func matchSet() {
        if validNumShapes() && validShapes() && validColors() && validShading() {
            validSet()
            matchedCards += selectedCards
            if deck.count > 2 {
                for card in selectedCards {
                    if let index = visibleCards.firstIndex(of: card) {
                        visibleCards[index] = deck.remove(at: deck.count.arc4random)
                    }
                }
            } else {
                for card in selectedCards {
                    if let index = visibleCards.firstIndex(of: card) {
                        visibleCards.remove(at: index)
                    }
                }
            }
        } else {
            invalidSet()
        }
        selectedCards = []
    }
    
    private mutating func validSet() {
        if visibleCards.count < 20 {
            score += 100
        } else if visibleCards.count < 40 {
            score += 50
        } else if visibleCards.count < 60 {
            score += 25
        } else {
            score += 10
        }
        if score > currBestScore {
           currBestScore = score
        }
    }
    
    private mutating func invalidSet() {
        score -= 50
    }
    
    mutating func saveScore() {
        if score > 0 {
            let newScore = Score(user: "Local User", score: score, date: Date())
            scores.append(newScore)
            save()
            UserDefaults.standard.set(currBestScore, forKey: "bestScore")
        }
    }
    
    private func save() {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(scores)
            try jsonData.write(to: fileURL)
        } catch {
            print(error)
        }
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
