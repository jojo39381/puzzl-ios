//
//  PaddedLabel.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += leftInset + rightInset
        size.height += topInset + bottomInset
        return size
    }
    
}

