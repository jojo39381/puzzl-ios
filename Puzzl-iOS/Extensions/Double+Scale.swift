//
//  Double+Scale.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension Double {
    
    var scalable: CGFloat {
        var scaleFactor = min(UIScreen.main.bounds.width / 375, 1.0)
        switch UIScreen.main.scale {
        case 3:
            scaleFactor *= 1
            break
        case 2:
            scaleFactor *= 0.85
            break
        case 1:
            scaleFactor *= 0.7
            break
        default:
            break
        }
        return CGFloat(self) * scaleFactor
    }
}
