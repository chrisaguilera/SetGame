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
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var scoreContainerView: UIView!
    @IBOutlet weak var bestScoreContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundTableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundTableView.layer.cornerRadius = 5.0
        scoreContainerView.layer.cornerRadius = 5.0
        bestScoreContainerView.layer.cornerRadius = 5.0
        newGameButton.layer.cornerRadius = 5.0
        dealButton.layer.cornerRadius = 5.0
        
        scoreLabel.text = String(set.score)
        bestScoreLabel.text = String(set.currBestScore)
        configureCollectionView()
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        set.saveBestScore()
        set = Set()
        updateView()
    }

    @IBAction func dealButtonPressed(_ sender: UIButton) {
        set.dealThreeCards()
        updateView()
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = GridFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func updateView() {
        scoreLabel.text = String(set.score)
        bestScoreLabel.text = String(set.currBestScore)
        collectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return set.visibleCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card Cell", for: indexPath) as! SetCardCollectionViewCell
        let card = set.visibleCards[indexPath.row]
        cell.configureCollectionViewCell(numShapes: card.numShapes.rawValue, shape: card.shape.rawValue, shading: card.shading.rawValue, color: card.color.rawValue)
        cell.configureBorder(isSelected: set.selectedCards.contains(card))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = set.visibleCards[indexPath.row]
        if set.selectedCards.count == 3 {
            set.select(card: card)
            updateView()
        } else if let cell = collectionView.cellForItem(at: indexPath) as? SetCardCollectionViewCell {
            set.select(card: card)
            cell.configureBorder(isSelected: set.selectedCards.contains(card))
        }
    }
    
}

