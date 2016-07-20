//
//  Request.swift
//  MultiThreadImageAPIProject
//
//  Created by Mylo Ho on 7/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class APIRequest {
    
    static func getRequestWith(method: String, url: String, parameter: NSDictionary?) -> NSURLRequest {
        
        var request = NSMutableURLRequest()
        
        if let url = NSURL(string: url) {
            request = NSMutableURLRequest(URL: url, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10.0)
            request.HTTPMethod = method
            request.allHTTPHeaderFields = parameter as? [String: String]
        }
        
        return request
        
    }
    
}

class APIProcess: NSObject {
    
    class var sharedInstance: APIProcess {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: APIProcess? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = APIProcess()
        }
        return Static.instance!
    }
    
    
    
}