//
//  CustomFont.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum AvenirFontStyle {
        case thin
        case medium
        case bold
        case regular
        case semibold
        case book
        case heavy
    }
    
    
    class func avenir(of size: CGFloat, weight: AvenirFontStyle) -> UIFont {
        var customFont: UIFont?
        switch weight {
            case .thin: customFont = UIFont(name: "Avenir-Thin", size: size)
            case .medium: customFont = UIFont(name: "Avenir-Medium", size: size)
            case .bold: customFont = UIFont(name: "Avenir-Bold", size: size)
            case .semibold: customFont = UIFont(name: "Avenir-Semibold", size: size)
            case .regular: customFont = UIFont(name: "Avenir-Regular", size: size)
            case .book: customFont = UIFont(name: "Avenir-Book", size: size)
            case .heavy: customFont = UIFont(name: "Avenir-Heavy", size: size)
        }
        return customFont ?? UIFont.systemFont(ofSize: size)
    }
}
