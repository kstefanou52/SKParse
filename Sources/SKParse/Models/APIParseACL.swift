//
//  APIParseACL.swift
//  SKParse
//
//  Created by kostis stefanou on 1/8/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

public struct APIParseACL: Codable {
    let publicPermission: PublicPermission?
    #warning("find the solution here about dyanmic key value in codables")
    let rcW3HPPCEJ: RCW3HPPCEJ?

    enum CodingKeys: String, CodingKey {
        case publicPermission = "*"
        case rcW3HPPCEJ
    }
}

public struct RCW3HPPCEJ: Codable {
    let read, write: Bool
}

public struct PublicPermission: Codable {
    let read, write: Bool?
}
