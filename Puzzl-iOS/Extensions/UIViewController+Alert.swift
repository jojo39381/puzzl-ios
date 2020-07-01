//
//  UIViewController+Alert.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/30/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }

        let firstAction = UIAlertAction(title: firstActionTitle ?? "OK", style: .default) { (action) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        self.present(alertController, animated: true)
    }
}
