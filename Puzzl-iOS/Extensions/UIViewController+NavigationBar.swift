//
//  UIViewController+NavigationBar.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureClearNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black.withAlphaComponent(0.54)]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black.withAlphaComponent(0.54)]
            navBarAppearance.backgroundColor = .clear
            navBarAppearance.shadowColor = .clear
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func stylizeNavigationFont(buttonTitle: String, color: UIColor = .white) {
        let customFont = UIFont.systemFont(ofSize: 13, weight: .semibold)

        var fontAttributes: [NSAttributedString.Key: Any]
        fontAttributes = [ NSAttributedString.Key.foregroundColor: color,
                           NSAttributedString.Key.font: customFont ]
        
        let backBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                style: .plain,
                                                target: nil,
                                                action: nil)
        backBarButtonItem.setTitleTextAttributes(fontAttributes, for: .normal)
        backBarButtonItem.tintColor = color
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
