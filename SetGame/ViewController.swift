//
//  ViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/3/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var set = Set()
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreContainerView.layer.cornerRadius = 5.0
        newGameButton.layer.cornerRadius = 5.0
        dealButton.layer.cornerRadius = 5.0
        updateView()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            let card = set.visibleCards[cardIndex]
            set.select(card: card)
            updateView()
        }
        
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        set = Set()
        updateView()
    }

    @IBAction func dealButtonPressed(_ sender: UIButton) {
        set.dealThreeCards()
        updateView()
    }
    
    private func updateView() {
        for index in set.visibleCards.indices {
            
            let cardButton = cardButtons[index]
            let card = set.visibleCards[index]
            cardButton.setAttributedTitle(text(for: card), for: .normal)
            cardButton.layer.cornerRadius = 5.0
            
            // Hide hidden cards
            if set.hiddenCards.contains(card) {
                cardButton.isHidden = true
            } else {
                cardButton.isHidden = false
            }
            
            // Hide cards if matched
            if set.matchedCards.contains(card) {
                cardButton.isHidden = true
            }
            
            // Update view for selected cards
            if set.selectedCards.contains(set.visibleCards[index]) {
                cardButton.layer.borderWidth = 3.0
                cardButton.layer.borderColor = #colorLiteral(red: 0.03697964922, green: 0.5169641376, blue: 1, alpha: 1)
            } else {
                cardButton.layer.borderWidth = 0.0
            }
            
            if set.hiddenCards.count != 0 || (set.selectedCards.count == 3 && set.deck.count > 0) {
                dealButton.isEnabled = true
                dealButton.alpha = 1.0
            } else {
                dealButton.isEnabled = false
                dealButton.alpha = 0.5
            }
            
        }
        
        scoreLabel.text = "\(set.score)"
    }
    
    private func text(for card: Card) -> NSAttributedString {
        var faceString = ""
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        switch card.shape {
        case .first: faceString = "▲"
        case .second: faceString = "●"
        case .third: faceString = "■"
        }
        
        switch card.numShapes {
        case.one: break
        case .two:
            faceString = faceString + faceString
        case .three:
            faceString = faceString + faceString + faceString
        }
        
        switch card.shading {
        case .first:
            switch card.color {
            case .first: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.3088752614, blue: 0.301250743, alpha: 1)
            case .second: attributes[.foregroundColor] = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            case .third: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1)
            }
        case .second:
            switch card.color {
            case .first: attributes[.foregroundColor] = UIColor(red: 255/255, green: 79/255, blue: 77/255, alpha: 0.20)
            case .second: attributes[.foregroundColor] = UIColor(red: 4/255, green: 150/255, blue: 255/255, alpha: 0.20)
            case .third: attributes[.foregroundColor] = UIColor(red: 255/255, green: 212/255, blue: 90/255, alpha: 0.20)
            }
        case .third:
            attributes[.strokeWidth] = 5
            switch card.color {
            case .first: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.3088752614, blue: 0.301250743, alpha: 1)
            case .second: attributes[.foregroundColor] = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            case .third: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1)
            }
        }
        
        return NSAttributedString(string: faceString, attributes: attributes)
    }


}

