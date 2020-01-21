//
//  Parse.swift
//  SKParse
//
//  Created by kostis stefanou on 1/6/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation
import SKKeychain

public final class Parse {
    
    public static var client: ParseClient!
    
    public static func initialize(withConfiguration configuration: ParseClientConfiguration) {
        self.client = ParseClient(configuration: configuration)
        retrieveTokenIfAnyAndSetIt()
    }
    
    private static func keychainQuery() -> KeychainQuery {
        return KeychainQuery {
            $0.accessGroup = "parse.sdk"
            $0.authenticationType = .Default
            $0.protocolType = .https
            $0.serverUrl = client.serverURL
            $0.secClass = .identity
        }
    }
    static func retrieveTokenIfAnyAndSetIt() {
        let retrievedToken: String? = try? Keychain(withQuery: keychainQuery()).retrieve()
        self.client.setTokenInHeaders(withKey: ParseConstants.PFCommandHeaderNameSessionToken, andValue: retrievedToken)
    }

    static func storeToken(_ token: String?) {
        guard let token = token else { return }
        try? Keychain(withQuery: keychainQuery()).store(value: token)
    }
}
