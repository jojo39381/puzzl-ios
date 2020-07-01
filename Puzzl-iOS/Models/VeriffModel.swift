//
//  VeriffModel.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/30/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation

class VeriffModel: Codable {
    var status: String
    var vendorData: String?
    var url: String
    var host: String
    var id: String
    var sessionToken: String
}

class VeriffAnswer: Codable {
    var verification: VeriffModel
}
