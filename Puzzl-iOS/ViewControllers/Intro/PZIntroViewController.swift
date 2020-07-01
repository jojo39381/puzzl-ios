//
//  PZIntroViewController.swift
//  Puzzl-iOS
//
//  Created by Denis Butyletskiy on 21/4/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import SafariServices

class PZIntroViewController: UIViewController {
    
    @IBOutlet var subtitleLabel: UILabel?
    @IBOutlet var stepsLabel: UILabel?
    @IBOutlet var previewLabel: TTTAttributedLabel?
    
    @IBOutlet var constraintTitleTop: NSLayoutConstraint? //65
    @IBOutlet var constraintSubTitleTop: NSLayoutConstraint? //26
    @IBOutlet var constraintStepsTop: NSLayoutConstraint? //32
    @IBOutlet var constraintStartTop: NSLayoutConstraint? //54
    
    
    @IBAction func closeAction(_ sender: Any) {
        showExit(noCompletion: {},
                 yesCompletion: { [weak self] in
                    Puzzl.delegate?.getStatus(status: .error)
                    self?.navigationController?.dismiss(animated: true, completion: nil) })
    }
    
    @IBAction func startAction(_ sender: Any) {
        let profileInformationViewController = UIViewController.profileInformation
        navigationController?.pushViewController(profileInformationViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stylizeNavigationFont(buttonTitle: "", color: UIColor.black.withAlphaComponent(0.54))
    }
}

// MARK: - Setup
extension PZIntroViewController {
    private func setup() {
        setupView()
        setupConstraints()
        setupPreviewLabel()
        setupNavigationBar()
    }
    
    private func setupView() {
        subtitleLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
        stepsLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
    }
    
    private func setupConstraints() {
        constraintTitleTop?.constant = 65.scalable
        constraintSubTitleTop?.constant = 26.scalable
        constraintStepsTop?.constant = 32.scalable
        constraintStartTop?.constant = 54.scalable
    }
    
    private func setupNavigationBar() {
        configureClearNavigationBar()
    }
    
    private func setupPreviewLabel() {
        guard let terms = URL(string:  "https://www.joinpuzzl.com/legal/terms-of-service"),
            let privacy = URL(string: "https://www.joinpuzzl.com/legal/privacy-policy/") else { return }
        
        previewLabel?.linkAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7),
                                       NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        previewLabel?.text = "By clicking ‘Next’, you agree to our Privacy Policy and Terms of Services"
        previewLabel?.addLink(to: privacy, with: NSRange(location: "By clicking ‘Next’, you agree to our ".count, length: "Privacy Policy".count))
        previewLabel?.addLink(to: terms, with: NSRange(location: "By clicking ‘Next’, you agree to our Privacy Policy and ".count, length: "Terms of Services".count))
        previewLabel?.delegate = self
    }
}

// MARK: - TTTAttributedLabelDelegate
extension PZIntroViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let safaryViewController = SFSafariViewController(url: url)
        present(safaryViewController, animated: true, completion: nil)
    }
}
