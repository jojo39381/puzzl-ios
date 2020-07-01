//
//  UIStoryboard+AppStroryboard.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class var main: UIStoryboard {
        let bundle = Bundle(identifier: "puzzle-dev.nyblecraft.Puzzl-iOS")
        return UIStoryboard(name: "Main", bundle: bundle)
    }
}
