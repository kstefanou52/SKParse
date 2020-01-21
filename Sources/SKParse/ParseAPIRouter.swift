//
//  ParseRouter.swift
//  SKParse
//
//  Created by kostis stefanou on 1/7/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation
import SKHTTPClient

/// https://docs.parseplatform.org/rest/guide/
enum ParseAPIRouter: String {
    
    // User API
    case signup = "users"
    case login = "login"
    case logout = "logout"
    case requestPasswordReset = "requestPasswordReset"
    
    // Cloud Functions API
    case cloudFunction = "functions"
    case cloudJob = "jobs"
    
    var method: HTTPClientConfigurations.Method {
        switch self {
        case .signup: return .POST
        case .login: return .GET
        case .logout: return .POST
        case.requestPasswordReset: return .POST
        case .cloudFunction: return .POST
        case .cloudJob: return .POST
        }
    }
    
//    var endpoint: URL {
//        return URL(string: "") // self.rawValue
//    }
}
