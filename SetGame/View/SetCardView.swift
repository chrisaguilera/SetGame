//
//  SetCardView.swift
//  SetGame
//
//  Created by Chris Aguilera on 5/5/19.
//  Copyright © 2019 Chris Aguilera. All rights reserved.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    
    @IBInspectable
    var numShapes: Int = 3 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shape: Int = 2 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shading: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var color: Int = 2 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var faceLabel = createFaceLabel()
    
    private func createFaceLabel() -> UILabel {
        let label = UILabel()
        addSubview(label)
        return label
    }
    
    private func configureFaceLabel() {
        faceLabel.attributedText = attributedString(fontSize: fontSize)
        faceLabel.frame.size = CGSize.zero
        faceLabel.sizeToFit()
    }
    
    private func attributedString(fontSize: CGFloat) -> NSAttributedString {
        var faceString = ""
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        switch shape {
        case 1: faceString = "▲"
        case 2: faceString = "●"
        case 3: faceString = "■"
        default: break
        }
        
        switch numShapes {
        case 2: faceString = faceString + faceString
        case 3: faceString = faceString + faceString + faceString
        default: break
        }
        
        switch shading {
        case 1:
            switch color {
            case 1: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            case 2: attributes[.foregroundColor] = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            case 3: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1)
            default: break
            }
        case 2:
            switch color {
            case 1: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1).withAlphaComponent(0.20)
            case 2: attributes[.foregroundColor] = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).withAlphaComponent(0.20)
            case 3: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1).withAlphaComponent(0.20)
            default: break
            }
        case 3:
            attributes[.strokeWidth] = 5
            switch color {
            case 1: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            case 2: attributes[.foregroundColor] = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            case 3: attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1)
            default: break
            }
        default: break
        }
        attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        return NSAttributedString(string: faceString, attributes: attributes)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureFaceLabel()
        faceLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    override func draw(_ rect: CGRect) {

        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }

}

extension SetCardView {
    
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.08
        static let fontSizeToBoundsHeight: CGFloat = 0.5
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var fontSize: CGFloat {
        return bounds.size.height * SizeRatio.fontSizeToBoundsHeight
    }
    
    private var colors: [UIColor] {
        return [#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.3529411765, alpha: 1)]
    }
    
}
