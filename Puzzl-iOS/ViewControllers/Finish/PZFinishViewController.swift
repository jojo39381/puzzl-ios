//
//  PZFinishViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PZFinishViewController: UIViewController {

    @IBOutlet var contentLabel: UILabel?
    @IBOutlet var finishButton: UIButton?
    
    @IBOutlet var constraintTitleTop: NSLayoutConstraint? //65
    @IBOutlet var constraintContentTop: NSLayoutConstraint? //56
    @IBOutlet var constraintFinishTop: NSLayoutConstraint? //65
    @IBOutlet var constarintFinishHeight: NSLayoutConstraint? //50
    
    @IBAction func finishAction(_ sender: Any) {
        ResponseService.shared.onboardWorker()
        navigationController?.dismiss(animated: true, completion: nil)
        Puzzl.delegate?.getStatus(status: .success)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension PZFinishViewController {
    private func setup() {
        setupContent()
        setupConstraint()
    }
    
    private func setupContent() {
        contentLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
        
        finishButton?.titleLabel?.font = UIFont.avenir(of: 20.scalable, weight: .heavy)
    }
    
    private func setupConstraint() {
        constraintTitleTop?.constant = 65.scalable
        constraintContentTop?.constant = 56.scalable
        constraintFinishTop?.constant = 65.scalable
        constarintFinishHeight?.constant = 50.scalable
    }
}
