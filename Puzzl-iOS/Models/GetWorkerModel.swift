//
//  GetWorkerModel.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

class GetWorkerModel: Codable {
    
    var createdAt: String
    var email: String
    var firstName: String
    var lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case createdAt
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
