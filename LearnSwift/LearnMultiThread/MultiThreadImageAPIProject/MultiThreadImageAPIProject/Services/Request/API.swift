//
//  Request.swift
//  MultiThreadImageAPIProject
//
//  Created by Mylo Ho on 7/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
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
    
    var data = NSMutableData()
    var connection: NSURLConnection!
    
    func connectAPI(request: NSURLRequest, complete: APIComplete) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            let session = NSURLSession.sharedSession()
            
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    if (error != nil) {
                        complete(data: nil, error: true, message: error?.localizedDescription)
                    } else {
                        complete(data: data, error: false, message: "Get Data Success!!")
                    }
                }
                
            })
            dataTask.resume()
        }
        
    }
    
}