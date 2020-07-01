//
//  PZExitViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PZExitViewController: UIViewController {
    
    public class func open(from vc: UIViewController, noCompletion: (()->())?, yesCompletion: (()->())?) {
        let viewController = UIViewController.exit
        viewController.noBlock = noCompletion
        viewController.yesBlock = yesCompletion
        vc.present(viewController, animated: true, completion: nil)
    }

    @IBOutlet var exitLabel: UILabel?
    @IBOutlet var noButton: UIButton?
    @IBOutlet var yesButton: UIButton?
    
    @IBOutlet var constraintTitleTop: NSLayoutConstraint? //65
    @IBOutlet var constraintSubtitleTop: NSLayoutConstraint? //140
    @IBOutlet var constraintButtonsBottom: NSLayoutConstraint? //16
    @IBOutlet var constraintButtonHeight: NSLayoutConstraint? //50
    
    private var noBlock: (()->())?
    private var yesBlock: (()->())?
    
    @IBAction func noAction(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.noBlock?()
        })
    }
    
    @IBAction func yesAction(_ sender: Any) {
        dismiss(animated: true, completion: { [weak self] in
            self?.yesBlock?()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension PZExitViewController {
    private func setup() {
        setupButtons()
        setupLabel()
        setupConstraints()
    }
    
    private func setupButtons() {
        guard let noButton = noButton else { return }
        noButton.titleLabel?.font = UIFont.avenir(of: 20.scalable, weight: .heavy)
        
        guard let yesButton = yesButton else { return }
        yesButton.titleLabel?.font = UIFont.avenir(of: 20.scalable, weight: .heavy)
        yesButton.layer.borderWidth = 1
        yesButton.layer.borderColor = #colorLiteral(red: 0.05490196078, green: 0.3921568627, blue: 0.862745098, alpha: 1)
    }
    
    private func setupLabel() {
        exitLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
    }
    
    private func setupConstraints() {
        constraintTitleTop?.constant = 65.scalable
        constraintSubtitleTop?.constant = 140.scalable
        constraintButtonsBottom?.constant = 16.scalable
        constraintButtonHeight?.constant = 50.scalable
    }
}
