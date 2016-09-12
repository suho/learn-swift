//
//  API.swift
//  APIAndGoogleMaps
//
//  Created by Mylo Ho on 7/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

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

typealias APIComplete = (data: NSData?, error: Bool, message: String!) -> Void

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
    
    func connectVenueAPI(request: NSURLRequest, complete: APIComplete) {
        
        
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, responce, error) in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if error != nil {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        complete(data: nil, error: true, message: error?.localizedDescription)
                    }
                    
                } else {
                    
                    dispatch_async(dispatch_get_main_queue()) { 
                        complete(data: data, error: false, message: "Get Data Success")
                    }
                    
                }
                
            }).resume()
        
    }
    
    
}