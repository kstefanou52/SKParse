//
//  APIParseUser.swift
//  wallster
//
//  Created by kostis stefanou on 1/8/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

public struct APIParseUser: Codable {
    let username: String
    let email: String
    let updatedAt: String
    let emailVerified: Bool?
    let acl: APIParseACL

    let createdAt: String
    let objectId: String
    let sessionToken: String
    
    enum CodingKeys: String, CodingKey {
        case username, email, updatedAt, emailVerified, createdAt, objectId, sessionToken
        case acl = "ACL"
    }
}
