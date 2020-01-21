//
//  APIParseNewObject.swift
//  SKParse
//
//  Created by kostis stefanou on 1/8/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

public struct APIParseNewObject: Codable {
    let createdAt: String
    let objectId: String
}

public struct APIParseNewUser: Codable {
    let createdAt: String
    let objectId: String
    let sessionToken: String
}
