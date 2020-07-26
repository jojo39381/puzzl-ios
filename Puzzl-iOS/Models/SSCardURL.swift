//
//  SSCardURL.swift
//  Puzzl-iOS
//
//  Created by Shiraz Chokshi on 7/26/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

class SSCardURL: Codable {
    var s3URL: String
    
    private enum CodingKeys: String, CodingKey {
        case s3URL = ""
    }
}
