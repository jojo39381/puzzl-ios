//
//  UIViewController+Exit.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    func showExit(noCompletion: (()->())?, yesCompletion: (()->())?) {
        PZExitViewController.open(from: self,
                                  noCompletion: noCompletion,
                                  yesCompletion: yesCompletion)
    }
}
