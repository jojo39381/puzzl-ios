//
//  BaseResponse.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation


public class BaseResponse<T: Codable>: Codable {
    
    public var success: Bool
    public var data: T?
    
    private enum CodingKeys: String, CodingKey {
        case success
        case data
    }
    
    public required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        success = try response.decode(Bool.self, forKey: .success)
        data = try response.decode(T?.self, forKey: .data)
    }
}
