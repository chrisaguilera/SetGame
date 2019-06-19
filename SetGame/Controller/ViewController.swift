//
//  ViewController.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/3/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

struct AppConstants {
    static let mainBackgroundColor: UIColor = UIColor(red: 244/255, green: 207/255, blue: 152/255, alpha: 1.0)
    static let topConstraint: CGFloat = 65
}

class ViewController: UIViewController {

    var set = Set()

    @IBOutlet weak var menuButton: UIButton!
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
        menuButton.layer.cornerRadius = 5.0
        bestScoreContainerView.layer.cornerRadius = 5.0
        dealButton.layer.cornerRadius = 5.0
        
        scoreLabel.text = String(set.score)
        bestScoreLabel.text = String(set.currBestScore)
        configureCollectionView()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: MenuViewController.self), let mvc = segue.destination as? MenuViewController {
            mvc.newGameHandler = {
                self.set.saveBestScore()
                self.set = Set()
                self.updateView()
                self.dismiss(animated: true, completion: nil)
            }
        }
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

