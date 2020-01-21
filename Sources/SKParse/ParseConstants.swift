//
//  ParseConstants.swift
//  SKParse
//
//  Created by kostis stefanou on 1/6/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

enum ParseConstants {
    static let PFCommandRunningDefaultMaxAttemptsCount = 5
    static let PFCommandHeaderNameApplicationId = "X-Parse-Application-Id"
    static let PFCommandHeaderNameClientKey = "X-Parse-Client-Key"
    static let PFCommandHeaderNameClientVersion = "X-Parse-Client-Version"
    static let PFCommandHeaderNameInstallationId = "X-Parse-Installation-Id"
    static let PFCommandHeaderNameAppBuildVersion = "X-Parse-App-Build-Version"
    static let PFCommandHeaderNameAppDisplayVersion = "X-Parse-App-Display-Version"
    static let PFCommandHeaderNameOSVersion = "X-Parse-OS-Version"
    static let PFCommandHeaderNameSessionToken = "X-Parse-Session-Token"
    static let PFCommandParameterNameMethodOverride = "_method"
}
