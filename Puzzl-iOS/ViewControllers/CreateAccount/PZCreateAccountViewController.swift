//
//  PZCreateAccountViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PZCreateAccountViewController: UIViewController {

    // MARK: - Label
    @IBOutlet var subtitleLabel: UILabel?
    @IBOutlet var descLabel: UILabel?
    @IBOutlet var docLabel: UILabel?
    @IBOutlet var secondDescLabel: UILabel?
    @IBOutlet var driverLabel: UILabel?
    @IBOutlet var passportLabel: UILabel?
    
    // MARK: - TextField
    @IBOutlet var emailTextField: TextField?
    @IBOutlet var passwordTextField: TextField?
    @IBOutlet var confirmPasswordTextField: TextField?
    
    // MARK: - Views
    @IBOutlet var firsView: UIScrollView?
    @IBOutlet var secondView: UIScrollView?
    
    // MARK: - Buttons
    @IBOutlet var driveButton: UIButton?
    @IBOutlet var passportButton: UIButton?
    @IBOutlet var verifyButton: UIButton?
    
    // MARK: - Constraints
    @IBOutlet var constraintTitleTop: NSLayoutConstraint? //65
    @IBOutlet var constraintSubtitleTop: NSLayoutConstraint? //11
    @IBOutlet var constraintDescTop: NSLayoutConstraint? //5
    @IBOutlet var constraintEmailTop: NSLayoutConstraint? //25
    @IBOutlet var constraintViewsTop: NSLayoutConstraint? //37
    @IBOutlet var constraintPasswordTop: NSLayoutConstraint? //18
    @IBOutlet var constreaintConfirmTop: NSLayoutConstraint? //18
    @IBOutlet var constraintChooseTop: NSLayoutConstraint? //30
    
    private var password: String?
    private var confirmPassword: String?
    
    @IBOutlet weak var pfScrollAccount: UIScrollView!
    @IBAction func driveAction(_ sender: UIButton) {
        firsView?.backgroundColor = #colorLiteral(red: 0.02058316767, green: 0.4855468869, blue: 0.8905407786, alpha: 1)
        secondView?.backgroundColor = .white
        PassingData.shared.isPassport = false
    }
    
    @IBAction func passportAction(_ sender: UIButton) {
        firsView?.backgroundColor = .white
        secondView?.backgroundColor = #colorLiteral(red: 0.02058316767, green: 0.4855468869, blue: 0.8905407786, alpha: 1)
        PassingData.shared.isPassport = true
    }
    
    @IBAction func verifyAction(_ sender: Any) {
        if validation() {
            PassingData.shared.password = password ?? ""
            ResponseService.shared.submitWorkerProfileInfo()
            if PassingData.shared.isPassport {
                navigationController?.pushViewController(.veriff, animated: true)
            } else {
                ResponseService.shared.generateSSCardPutURL { (response) in
                            if let response = response.response {
                                print("Successfully created profile")

                //                PassingData.shared.signW2Model.createdAt = response.createdAt
                            } else if let _ = response.error {
                                print(response.error)
                                print("Internal Error")
                            }
                        }

                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pfScrollAccount.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)

        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        emailTextField!.text = "\(PassingData.shared.employeeModel!.email)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stylizeNavigationFont(buttonTitle: "", color: UIColor.black.withAlphaComponent(0.54))
    }
}


// MARK: - Setup
extension PZCreateAccountViewController {
    private func setup() {
        setupContraints()
        setupView()
        configureViews()
        setupButton()
        configureTextField(emailTextField, placeholder: "Email")
        configureTextField(passwordTextField, placeholder: "Password")
        configureTextField(confirmPasswordTextField, placeholder: "Confirm Password")
        hideKeyboardWhenTappedAround()
    }
    
    private func setupView() {
        subtitleLabel?.font = UIFont.avenir(of: 24.scalable, weight: .medium)
        descLabel?.font = UIFont.avenir(of: 14.scalable, weight: .medium)
        docLabel?.font = UIFont.avenir(of: 19.scalable, weight: .medium)
        secondDescLabel?.font = UIFont.avenir(of: 15.scalable, weight: .medium)
        driverLabel?.font = UIFont.avenir(of: 16.scalable, weight: .medium)
        passportLabel?.font = UIFont.avenir(of: 16.scalable, weight: .medium)
    }
    
    private func setupContraints() {
        constraintTitleTop?.constant = 65.scalable
        constraintSubtitleTop?.constant = 11.scalable
        constraintDescTop?.constant = 5.scalable
        constraintEmailTop?.constant = 25.scalable
        constraintViewsTop?.constant = 37.scalable
        constraintPasswordTop?.constant = 18.scalable
        constreaintConfirmTop?.constant = 18.scalable
        constraintChooseTop?.constant = 30.scalable
    }
    
    private func configureViews() {
        guard let firsView = firsView else { return }
        firsView.backgroundColor = .white
        firsView.layer.borderWidth = 3
        firsView.layer.borderColor = #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 1)
        firsView.layer.cornerRadius = firsView.frame.height / 2
        
        guard let secondView = secondView else { return }
        secondView.backgroundColor = .white
        secondView.layer.borderWidth = 3
        secondView.layer.borderColor = #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 1)
        secondView.layer.cornerRadius = secondView.frame.height / 2
    }
    
    private func setupButton() {
        verifyButton?.titleLabel?.font = UIFont.avenir(of: 18.scalable, weight: .heavy)
        verifyButton?.layer.cornerRadius = 5
    }
}

// MARK: - Helpers
extension PZCreateAccountViewController {
    private func configureTextField(_ textField: TextField?, placeholder: String) {
        textField?.backgroundColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        textField?.layer.borderColor = #colorLiteral(red: 0.8829681277, green: 0.8829888701, blue: 0.8829776645, alpha: 1)
        textField?.layer.borderWidth = 2
        textField?.layer.cornerRadius = 3
        textField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 1)])
        textField?.delegate = self
        
    }
    
    private func validation() -> Bool {
        guard let password = password,
            let confirm = confirmPassword else { showDefaultAlert(title: "Something went wrong"); return false }
        if password.count < 8 { showDefaultAlert(title: "Password error"); return false }
        if password != confirm { showDefaultAlert(title: "Confirm password error"); return false }
        return true
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
//        Animator.makeMoveAnimation(view: view, translationY: -125.0)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
//       Animator.makeMoveAnimation(view: view, translationY: 0)
        if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
    }
}

// MARK: - UITextFieldDelegate
extension PZCreateAccountViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            PassingData.shared.signW2Model.email = textField.text ?? ""
        case passwordTextField:
            password = textField.text ?? ""
        case confirmPasswordTextField:
            confirmPassword = textField.text ?? ""
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension PZCreateAccountViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            PassingData.shared.driversPhoto = image
        }
        picker.dismiss(animated: true, completion: { [weak self] in
            self?.navigationController?.pushViewController(.veriff, animated: true)
        })
        ResponseService.shared.uploadSSCard()
    }
}
