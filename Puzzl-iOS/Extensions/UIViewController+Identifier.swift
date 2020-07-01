//
//  UIViewController+Identifier.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}
