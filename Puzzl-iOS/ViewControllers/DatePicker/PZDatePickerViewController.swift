//
//  PZDatePickerViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PZDatePickerViewController: UIViewController {

    class func open(from: UIViewController, mode: UIDatePicker.Mode = .date, popupTitle: String, selectedDate: Date? = nil, isBirthday: Bool = true) -> PZDatePickerViewController {
        let datePickerViewController = UIViewController.datePicker
        datePickerViewController.mode = mode
        datePickerViewController.popupTitle = popupTitle
        datePickerViewController.selectedDate = selectedDate
        datePickerViewController.isBirthday = isBirthday
        from.addChild(datePickerViewController)
        from.view.addSubview(datePickerViewController.view)
        datePickerViewController.view.frame = from.view.frame
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if #available(iOS 10.0, *) {
                datePickerViewController.showPicker()
            }
        }
        return datePickerViewController
    }
    
    public var mode: UIDatePicker.Mode!
    public var popupTitle: String?
    public var selectedDate: Date?
    public var onDateSelection: ((Date?) -> ())?
    public var onClose: (() -> ())?
    
    @IBOutlet var blurView: UIVisualEffectView?
    @IBOutlet var pickerView: UIView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var datePicker: UIDatePicker?
    @IBOutlet var doneButton: UIButton?
    
    @IBOutlet var constraintBottom: NSLayoutConstraint?
    
    private var isBirthday = false
    
    deinit {
        popupTitle = nil
        selectedDate = nil
        onDateSelection = nil
        onClose = nil
    }
    
    private let pickerViewHeight: CGFloat = 295
    
    private var safeAreaBottomInset: CGFloat {
        if #available(iOS 11.0, *) { return UIApplication.shared.keyWindow!.safeAreaInsets.bottom }
        else { return 20 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial setup
        blurView?.effect = nil
        titleLabel?.text = popupTitle
        doneButton?.setTitle("Submit", for: .normal)
        doneButton?.titleLabel?.font = UIFont.systemFont(ofSize: 17.scalable, weight: .medium)
        
        constraintBottom?.constant = -(pickerViewHeight + safeAreaBottomInset)
        
        datePicker?.datePickerMode = mode
        datePicker?.setValue(UIColor.black, forKey: "textColor")
        datePicker?.setValue(false, forKey: "highlightsToday")
        
        if mode == .date {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: Date())
            components.year = components.year?.advanced(by: -18)
            if isBirthday {
                datePicker?.maximumDate = calendar.date(from: components)
            }
            components.year = components.year?.advanced(by: -5)
            if let settableDate = calendar.date(from: components) {
                datePicker?.setDate(settableDate, animated: false)
            }
        }
        
        if let selectedDate = selectedDate {
            datePicker?.setDate(selectedDate, animated: false)
        }
        
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
        blurView?.addGestureRecognizer(tapOutside)
    }
    
    @objc func tappedOutside() {
        onClose?()
        if #available(iOS 10.0, *) {
            hidePicker()
        } else {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @IBAction func clickedDone(_ sender: UIButton) {
        onDateSelection?(datePicker?.date)
        if #available(iOS 10.0, *) {
            hidePicker()
        } else {
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @available(iOS 10.0, *)
    @objc func showPicker() {
        constraintBottom?.constant = -15
        UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.pickerView?.layer.cornerRadius = 15
            }.startAnimation()
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.blurView?.effect = UIBlurEffect(style: .dark)
        }) { _ in }
    }
    
    @available(iOS 10.0, *)
    @objc func hidePicker() {
        constraintBottom?.constant = -(pickerViewHeight + safeAreaBottomInset)
        UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.pickerView?.layer.cornerRadius = 0
            }.startAnimation()
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.blurView?.effect = nil
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
}

