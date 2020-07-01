//
//  GetUserModel.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

class GetUserModel: Codable {
    var businessName: String
    var businessEmail: String
    
    private enum CodingKeys: String, CodingKey {
        case businessName = "business_name"
        case businessEmail = "business_email"
    }
}
