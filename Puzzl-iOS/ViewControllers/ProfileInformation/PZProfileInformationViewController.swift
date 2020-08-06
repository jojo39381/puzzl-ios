//
//  PZProfileInformationViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/28/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PZProfileInformationViewController: UIViewController {

    // MARK: - Text Fields
    @IBOutlet var firstNameTextField: TextField?
    @IBOutlet var miTextField: TextField?
    @IBOutlet var lastNameTextField: TextField?
    @IBOutlet var phoneNumberTextField: TextField?
    @IBOutlet var firstSocialNumberTextField: TextField?
    @IBOutlet var secondSocialNumberTextField: TextField?
    @IBOutlet var thirdSocialNumberTextField: TextField?
    @IBOutlet var addressTextField: TextField?
    @IBOutlet var stateTextField: TextField?
    @IBOutlet var zipTextField: TextField?
    @IBOutlet var cityTextField: TextField?
    
    // MARK: - Label
    @IBOutlet var dateLabel: PaddedLabel?
    @IBOutlet var dateNameLabel: UILabel?
    @IBOutlet var socialSecurityNumberLabel: UILabel?
    
    // MARK: - Button
    @IBOutlet var createButton: UIButton?

    // MARK: - Constraints
    @IBOutlet var constraintTitleTop: NSLayoutConstraint? //65
    @IBOutlet var constraintSubtitleTop: NSLayoutConstraint? //11
    @IBOutlet var constraintViewsHeight: NSLayoutConstraint? //37
    @IBOutlet var constraintFirstNameTop: NSLayoutConstraint? //22
    @IBOutlet var conatraintDateNameTop: NSLayoutConstraint? //17
    @IBOutlet var constraintSSNTop: NSLayoutConstraint? //11
    @IBOutlet var constraintButtonTop: NSLayoutConstraint? //32
    @IBOutlet var constraintButtonHeight: NSLayoutConstraint? //50
    

    @IBOutlet weak var pfScroll: UIScrollView!
    private var ssn1: String?
    private var ssn2: String?
    private var ssn3: String?
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    private lazy var fullDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df
    }()
    
    @IBAction func closeAction(_ sender: Any) {
        showExit(noCompletion: {},
                 yesCompletion: { [weak self] in
                    Puzzl.delegate?.getStatus(status: .error)
                    self?.navigationController?.dismiss(animated: true, completion: nil) })
    }
    
    @IBAction func createAction(_ sender: Any) {
        let stirng = "\(ssn1 ?? "0")\(ssn2 ?? "0")\(ssn3 ?? "0")"
        PassingData.shared.last4 = ssn3
        PassingData.shared.signW2Model.ssn = stirng
        let createAccount = UIViewController.createAccount
        navigationController?.pushViewController(createAccount, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pfScroll.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        firstNameTextField!.text = "\(PassingData.shared.employeeModel!.firstName)"
        lastNameTextField!.text = "\(PassingData.shared.employeeModel!.lastName)"
        
    }
    
//   override func viewDidLayoutSubviews() {
//    self.pfScroll.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
//
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stylizeNavigationFont(buttonTitle: "", color: UIColor.black.withAlphaComponent(0.54))
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
}

// MARK: - Setup
extension PZProfileInformationViewController {
    private func setup() {
        setupConstraints()
        setupLabels()
        setupButton()
        configureTextField(firstNameTextField, placeholder: "First Name")
        configureTextField(miTextField, placeholder: "MI")
        configureTextField(lastNameTextField, placeholder: "Last Name")
        configureTextField(phoneNumberTextField, placeholder: "Phone Number")
        configureTextField(firstSocialNumberTextField, placeholder: "")
        configureTextField(secondSocialNumberTextField, placeholder: "")
        configureTextField(thirdSocialNumberTextField, placeholder: "")
        configureTextField(addressTextField, placeholder: "Address")
        configureTextField(stateTextField, placeholder: "State")
        configureTextField(zipTextField, placeholder: "Zip")
        configureTextField(cityTextField, placeholder: "City")
        configureLabel(dateLabel, text: "mm/dd/yyyy")
        hideKeyboardWhenTappedAround()
    }
    
    private func setupConstraints() {
        constraintTitleTop?.constant = 65.scalable
        constraintSubtitleTop?.constant = 11.scalable
        constraintViewsHeight?.constant = 37.scalable
        constraintFirstNameTop?.constant = 22.scalable
        conatraintDateNameTop?.constant = 17.scalable
        constraintSSNTop?.constant = 11.scalable
        constraintButtonTop?.constant = 32.scalable
        constraintButtonHeight?.constant = 50.scalable
    }
    
    private func setupLabels() {
        dateNameLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
        socialSecurityNumberLabel?.font = UIFont.avenir(of: 20.scalable, weight: .medium)
    }
    
    private func setupButton() {
        createButton?.titleLabel?.font = UIFont.avenir(of: 18.scalable, weight: .heavy)
        createButton?.layer.cornerRadius = 5
    }
}

// MARK: - Helpers
extension PZProfileInformationViewController {
    private func configureTextField(_ textField: TextField?, placeholder: String) {
        textField?.backgroundColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        textField?.layer.borderColor = #colorLiteral(red: 0.8829681277, green: 0.8829888701, blue: 0.8829776645, alpha: 1)
        textField?.layer.borderWidth = 2
        textField?.layer.cornerRadius = 3
        textField?.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 1)])
        
        textField?.delegate = self
    }
    
    private func configureLabel(_ label: PaddedLabel?, text: String) {
        label?.backgroundColor = #colorLiteral(red: 0.9906734824, green: 0.990696609, blue: 0.9906842113, alpha: 1)
        label?.layer.borderColor = #colorLiteral(red: 0.8829681277, green: 0.8829888701, blue: 0.8829776645, alpha: 1)
        label?.layer.borderWidth = 2
        label?.layer.cornerRadius = 3
        label?.text = text
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        label?.isUserInteractionEnabled = true
        label?.addGestureRecognizer(tapGesture)
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
    
    @objc
    private func showDatePicker() {
        dismissKeyboard()
        let datePicker = PZDatePickerViewController.open(from: self, popupTitle: "Choose date")
        datePicker.onDateSelection = { [weak self] date in
            guard let date = date else { return }
            self?.dateLabel?.text = self?.dateFormatter.string(from: date)
            PassingData.shared.dob = self?.fullDateFormatter.string(from: date)
            self?.dateLabel?.textColor = .black
        }
    }
}

// MARK: - UITextFieldDelegate
extension PZProfileInformationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            PassingData.shared.signW2Model.firstName = textField.text ?? ""
        case lastNameTextField:
            PassingData.shared.signW2Model.lastName = textField.text ?? ""
        case miTextField:
            PassingData.shared.signW2Model.middlInitial = textField.text ?? ""
        case phoneNumberTextField:
            PassingData.shared.signW2Model.phoneNumber = textField.text ?? ""
        case addressTextField:
            PassingData.shared.signW2Model.address = textField.text ?? ""
        case stateTextField:
            PassingData.shared.signW2Model.state = textField.text ?? ""
        case zipTextField:
            PassingData.shared.signW2Model.zip = textField.text ?? ""
        case cityTextField:
            PassingData.shared.signW2Model.city = textField.text ?? ""
        case firstSocialNumberTextField:
            ssn1 = textField.text ?? ""
        case secondSocialNumberTextField:
            ssn2 = textField.text ?? ""
        case thirdSocialNumberTextField:
            ssn3 = textField.text ?? ""
        default:
            break
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}

