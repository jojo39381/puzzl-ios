//
//  SignW2Model.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/30/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

class SignW2Model: Codable {
    var companyID: String
    var firstName: String
    var lastName: String
    var middlInitial: String?
    var address: String
    var city: String
    var state: String
    var zip: Int
    var ssn: String
    var email: String
    var phoneNumber: String
    var createdAt: String
    var title: String
    var defaultWage: Double
    var defaultOtWage: Double
    
    private enum CodingKeys: String, CodingKey {
        case createdAt
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case companyID
        case middlInitial = "middle_initial"
        case address
        case city
        case state
        case zip
        case ssn
        case phoneNumber = "phone_number"
        case title
        case defaultWage
        case defaultOtWage
        
    }
    
    init() {
        companyID = "\(Puzzl.companyID)"
        firstName = ""
        lastName = ""
        middlInitial = ""
        address = ""
        city = ""
        state = ""
        state = ""
        zip = 0
        ssn = ""
        email = ""
        phoneNumber = ""
        createdAt = ""
        title = ""
        defaultWage = 0.0
        defaultOtWage = 0.0
        
    }
}
