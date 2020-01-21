//
//  ParseClient.swift
//  wallster
//
//  Created by kostis stefanou on 1/7/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation
import SKHTTPClient

final public class ParseClient: HTTPClient {
    
    private let configuration: ParseClientConfiguration
        
    override public var serverURL: URL {
        return URL(string: configuration.server!)!
    }
    
    init(configuration: ParseClientConfiguration) {
        self.configuration = configuration
    }
    
    override public var session: URLSession {
        let sessionConfiguration = ParseClientConfiguration.urlSessionConfiguration(forApplicationId: configuration.applicationId!, clientKey: configuration.clientKey)
        return URLSession(configuration: sessionConfiguration)
    }
    
    override public func createURLRequest(endPoint: URL, method: HTTPClientConfigurations.Method, urlParams: [String : Any] = [:], headers: [String : String]? = nil, body: [String : Any]? = nil) -> URLRequest? {
        // From Parse SDK : The request URI may be too long to include parameters in the URI. To avoid this problem we send the parameters in a POST request json-encoded body
        // and add a custom parameter that overrides the method in a request.
        if var body = body, method != .POST {
            body[ParseConstants.PFCommandParameterNameMethodOverride] = method.rawValue
        }
        return super.createURLRequest(endPoint: endPoint, method: method, urlParams: urlParams, headers: headers, body: body)
    }
}

// MARK: - API

extension ParseClient {
    public func signup(withUsername username: String, password: String, otherData: [String: Any], completion: @escaping(APIParseNewUser?, HTTPClientError<APIParseError>?) -> Void) {
        let parameters: [String: Any] = ["username": username, "password": password]
        let url = serverURL.appendingPathComponent(ParseAPIRouter.signup.rawValue)
        let request = createURLRequest(endPoint: url, method: .POST, body: parameters)
        
        performURLDataTask(with: request, completion: completion)
    }
    
    public func login(withUsername username: String, password: String, completion: @escaping(APIParseUser?, HTTPClientError<APIParseError>?) -> Void) {
        let parameters: [String: Any] = ["username": username, "password": password]
        let url = serverURL.appendingPathComponent(ParseAPIRouter.login.rawValue)
        let request = createURLRequest(endPoint: url, method: .POST, body: parameters)
        
        performURLDataTask(with: request) { (user: APIParseUser?, error: HTTPClientError<APIParseError>?) in
            self.setTokenInHeaders(withKey: ParseConstants.PFCommandHeaderNameSessionToken, andValue: user?.sessionToken)
            Parse.storeToken(user?.sessionToken)
            completion(user, error)
        }
    }
    
    public func cloudFunction<T: Codable>(withName name: String, andParameters parameters: [String: Any], completion: @escaping(T?, HTTPClientError<APIParseError>?) -> Void) {
        let url = serverURL.appendingPathComponent(ParseAPIRouter.cloudFunction.rawValue)
        let request = createURLRequest(endPoint: url, method: .POST, body: parameters)
        
        performURLDataTask(with: request, completion: completion)
    }
}
