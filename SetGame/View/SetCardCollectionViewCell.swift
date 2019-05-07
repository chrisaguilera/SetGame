//
//  SetCardCollectionViewCell.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/6/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

class SetCardCollectionViewCell: UICollectionViewCell {
    
    func configureCollectionViewCell(numShapes: Int, shape: Int, shading: Int, color: Int) {
        let cardView = SetCardView(frame: bounds)
        cardView.numShapes = numShapes
        cardView.shape = shape
        cardView.shading = shading
        cardView.color = color
        
        layer.cornerRadius = cornerRadius
        addSubview(cardView)
    }
    
    func configureBorder(isSelected: Bool) {
        if isSelected {
            layer.borderWidth = borderWidth
            layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        } else {
            layer.borderWidth = 0.0
        }
    }
    
}

extension SetCardCollectionViewCell {
    private struct SizeRatio {
        static let borderWidthToBoundsHeight: CGFloat = 0.05
        static let cornerRadiusToBoundsHeight: CGFloat = 0.08
    }
    
    private var borderWidth: CGFloat {
        return bounds.size.height * SizeRatio.borderWidthToBoundsHeight
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
}
