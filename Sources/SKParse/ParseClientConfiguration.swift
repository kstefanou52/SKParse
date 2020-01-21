//
//  ParseClientConfiguration.swift
//  SKParse
//
//  Created by kostis stefanou on 1/6/20.
//  Copyright © 2020 silonk. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(WatchKit)
import WatchKit
#endif

public protocol ParseMutableClientConfiguration: NSObjectProtocol {
    
    // MARK: - Connecting to Parse
    
    /**
     The Parse.com application id to configure the SDK with.
     */
    var applicationId: String? { get set }
    /**
     The Parse.com client key to configure the SDK with.
     */
    var clientKey: String? { get set }
    /**
     The URL of the server that is being used by the SDK.
     Defaults to `https://api.parse.com/1`.
     
     @note Setting this property to a non-valid URL or `nil` will throw an `NSInvalidArgumentException`.
     */
    var server: String? { get set }
    
    // MARK: - Network Properties
    
    /**
     A custom NSURLSessionConfiguration configuration that will be used from the SDK.
     */
    var urlSessionConfiguration: URLSessionConfiguration? { get set }
    /**
     The maximum number of retry attempts to make upon a failed network request.
     */
    var networkRetryAttempts: Int { get set }
}

public final class ParseClientConfiguration: NSObject, ParseMutableClientConfiguration {
    
    public var applicationId: String?
    
    public var clientKey: String?
    
    public var server: String?
    
    public var urlSessionConfiguration: URLSessionConfiguration?
    
    public var networkRetryAttempts: Int
    
    public init(completion: (ParseMutableClientConfiguration) -> (Void)) {
        self.networkRetryAttempts = ParseConstants.PFCommandRunningDefaultMaxAttemptsCount
        super.init()
        completion(self)
    }
    
    static public func urlSessionConfiguration(forApplicationId applicationId: String, clientKey: String?) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false
        configuration.urlCache = URLCache.init(memoryCapacity: URLCache.shared.memoryCapacity, diskCapacity: 0, diskPath: nil)
        
        var headers: [AnyHashable: Any] = defaultURLRequestHeaders(forApplicationId: applicationId, clientKey: clientKey, bundle: Bundle.main)
        
        if let httpAdditionalHeaders = configuration.httpAdditionalHeaders, !httpAdditionalHeaders.isEmpty {
            let sessionConfigurationHeaders: NSMutableDictionary = httpAdditionalHeaders as! NSMutableDictionary
            sessionConfigurationHeaders.addEntries(from: headers)
            headers = sessionConfigurationHeaders as! [AnyHashable : Any]
        }
        
        configuration.httpAdditionalHeaders = headers
        
        return configuration
    }
    
    static private func defaultURLRequestHeaders(forApplicationId applicationId: String, clientKey: String?, bundle: Bundle) -> [String: String] {
        let versionPrefix: String = {
            #if os(iOS)
            return "i"
            #elseif os(macOS)
            return "osx"
            #elseif os(tvOS)
            return "apple-tv"
            #elseif os(watchOS)
            return "apple-watch"
            #endif
        }()
        
        let osName: String = {
            #if os(iOS) || os(tvOS)
            return UIDevice.current.systemVersion
            #elseif os(macOS)
            return ProcessInfo.processInfo.operatingSystemVersionString
            #elseif os(watchOS)
            return WKInterfaceDevice.currentDevice().systemVersion
            #endif
        }()
        
        #warning("find a place for parse version")
        let parseVersion: String = "sk-0.0.1"
        
        var mutableHeaders: [String: String] = [:]
        mutableHeaders[ParseConstants.PFCommandHeaderNameApplicationId] = applicationId
        if let clientKey = clientKey {
            mutableHeaders[ParseConstants.PFCommandHeaderNameClientKey] = clientKey
        }
        
        mutableHeaders[ParseConstants.PFCommandHeaderNameClientVersion] = versionPrefix + parseVersion
        mutableHeaders[ParseConstants.PFCommandHeaderNameOSVersion] = osName
        
        
        // Bundle Version and Display Version can be null, when running tests
        if let bundleVersion = bundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
            mutableHeaders[ParseConstants.PFCommandHeaderNameAppBuildVersion] = bundleVersion
        }
        
        if let displayVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            mutableHeaders[ParseConstants.PFCommandHeaderNameAppDisplayVersion] = displayVersion
        }
        
        return mutableHeaders
    }
}
