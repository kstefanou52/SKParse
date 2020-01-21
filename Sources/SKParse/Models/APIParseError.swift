//
//  APIParseError.swift
//  SKParse
//
//  Created by kostis stefanou on 1/7/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

public class APIParseError: Codable {
    let code: Int
    let error: String
}
