//
//  PassingData.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

class PassingData {
    static let shared = PassingData()
    
    public var firstGetUserModel: GetUserModel?
    public var employeeModel: GetEmployeeModel?
    public var signW2Model = SignW2Model()
    public var helloSignModel: HellosignModel?
    public var SSCardURL: SSCardURL?
    
    
    public var isPassport = true
    public var password: String = ""
    public var veriffId: String = ""
    public var driversPhoto: UIImage?
    public var dob: String?
    public var last4: String?
}
