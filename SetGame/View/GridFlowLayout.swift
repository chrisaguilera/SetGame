//
//  GridFlowLayout.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/6/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        var cols: CGFloat = 0.0
        switch cv.numberOfItems(inSection: 0) {
        case 0...30:
            cols = 3.0
            self.minimumInteritemSpacing = 9.0
            self.minimumLineSpacing = 9.0
        case 31...52:
            cols = 4.0
            self.minimumInteritemSpacing = 6.0
            self.minimumLineSpacing = 5.0
        case 53...81:
            cols = 5.0
            self.minimumInteritemSpacing = 3.0
            self.minimumLineSpacing = 3.5
        default:
            cols = 3.0
        }
    
        let width = (cv.bounds.width - (cols - 1) * self.minimumInteritemSpacing) / cols
        let height = width * (0.5)
        self.itemSize = CGSize(width: width, height: height)
    }
}
