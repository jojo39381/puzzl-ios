//
//  UIViewController+AppControllers.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {

    class var start: RootNavigationController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: RootNavigationController.identifier) as! RootNavigationController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var exit: PZExitViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZExitViewController.identifier) as! PZExitViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var finish: PZFinishViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZFinishViewController.identifier) as! PZFinishViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var profileInformation: PZProfileInformationViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZProfileInformationViewController.identifier) as! PZProfileInformationViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var datePicker: PZDatePickerViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZDatePickerViewController.identifier) as! PZDatePickerViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var createAccount: PZCreateAccountViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZCreateAccountViewController.identifier) as! PZCreateAccountViewController
        print("Account Created")
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var veriff: PZVeriffViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZVeriffViewController.identifier) as! PZVeriffViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    class var webView: PZWebViewController {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: PZWebViewController.identifier) as! PZWebViewController
        if #available(iOS 13.0, *) { viewController.isModalInPresentation = false }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
