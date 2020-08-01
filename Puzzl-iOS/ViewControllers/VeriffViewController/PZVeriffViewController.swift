//
//  VeriffViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/30/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit
import Veriff
import AVFoundation

class PZVeriffViewController: UIViewController {

    
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df
    }()
    
    
    @IBAction func nextAction(_ sender: Any) {
        
        print(PassingData.shared.signW2Model.dictionary ?? [:])
        ResponseService.shared.signW2(parameters: PassingData.shared.signW2Model.dictionary ?? [:], completion: { [weak self] response in
            if let error = response.error { self?.showDefaultAlert(title: error.message as! String ?? "") }
            else if let model = response.response {
                PassingData.shared.helloSignModel = model
                
                self?.navigationController?.pushViewController(.webView, animated: true)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stylizeNavigationFont(buttonTitle: "", color: UIColor.black.withAlphaComponent(0.54))
    }
}

// MARK: - Helpers
extension PZVeriffViewController {
    private func checkMicPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            checkCameraPermissions()
        case .denied:
            print("Error with permissions")
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ [weak self] (granted) in
                if granted { self?.checkCameraPermissions() }
            })
        default:
            break
        }
    }
    
    private func checkCameraPermissions()  {
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

        switch cameraAuthorizationStatus {
        case .denied: print("Error with permissions")
        case .authorized: configure()
        case .restricted: print("Error with permissions")

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { [weak self] granted in
                if granted { self?.configure() }
            }
        }
    }
}

// MARK: - Setup
extension PZVeriffViewController {
    private func configure() {
        
        
        ResponseService.shared.configureVeriff(firstName: PassingData.shared.signW2Model.firstName,
                                               lastName: PassingData.shared.signW2Model.lastName,
                                               timestamp: dateFormatter.string(from: Date()),
                                               document: PassingData.shared.isPassport ? ["type" : "PASSPORT", "country" : "US"] : ["type" : "DRIVERS_LICENSE", "country" : "US"],
                                               completion: { [weak self] response in
                                                if let error = response.error { self?.showDefaultAlert(title: error.message as! String ?? "") }
                                                else if let verification = response.response?.verification {
                                                    PassingData.shared.veriffId = verification.id
                                                    self?.veriff(url: verification.host , token: verification.sessionToken)
                                                }
                                                print("----------------------")
                                                print("VERIFF ID")
                                                    print(PassingData.shared.veriffId)
                                                print("----------------------")
        })
    }
    
    private func veriff(url: String, token: String) {
        let veriff = Veriff.shared
        if let conf = VeriffConfiguration(sessionToken: token, sessionUrl: url) {
            veriff.set(configuration: conf)
            veriff.delegate = self
            veriff.startAuthentication()
            
        }
    }
}

// MARK: - VeriffDelegate
extension PZVeriffViewController: VeriffDelegate {
    func onSession(result: VeriffResult, sessionToken: String) {
        switch result.code {
            case .STATUS_DONE:
               print("doce")
            case .STATUS_ERROR_SESSION:
               print("error")
            default: break
        }
    }
}
