//
//  Puzzl.swift
//  Puzzl-iOS
//
//  Created by Denis Butyletskiy on 21/4/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

public enum PuzzlStatus {
    case success
    case error
}

public protocol PuzzlDelegate: class {
    func getStatus(status: PuzzlStatus)
}

public class Puzzl {
    
    static let shared = Puzzl()
    
    static var apiKey = String()
    static var companyID = String()
    static var workerID = String()
    static var error = String()
    
    static weak var delegate: PuzzlDelegate?
    
    public class func setDelegate(from vc: UIViewController) {
        delegate = vc as! PuzzlDelegate
    }
    
    public class func showOnboardingWith(apiKey: String, companyID: String, workerID: String, from vc: UIViewController) {
        self.apiKey = apiKey
        self.companyID = companyID
        self.workerID = workerID
        
        let group = DispatchGroup()
        
        group.enter()
        ResponseService.shared.getUserInfo { (response) in
            if let response = response.response {
                PassingData.shared.firstGetUserModel = response
                print("success getUserInfo")
            } else if let _ = response.error {
                self.error = "Error"
            }
            group.leave()
        }
        
        group.enter()
        ResponseService.shared.getWorkerInfo { (response) in
            if let response = response.response {
                PassingData.shared.workerModel = response
                print("success getWorkerInfo")
                
                PassingData.shared.signW2Model.createdAt = response.createdAt
            } else if let _ = response.error {
                self.error = "Error"
            }
            group.leave()
        }
        
        group.notify(queue: .main, execute: {
            if self.error == "Error" {
                self.delegate?.getStatus(status: .error)
            } else {
                let startOnboarding: UIViewController = .start
                startOnboarding.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                vc.present(startOnboarding, animated: true, completion: nil)
            }
        })
    }
}
