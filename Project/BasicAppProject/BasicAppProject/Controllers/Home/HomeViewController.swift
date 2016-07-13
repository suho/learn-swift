//
//  HomeViewController.swift
//  BasicAppProject
//
//  Created by Mylo Ho on 7/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: String = "https://api.foursquare.com/v2/venues/search?oauth_token=3IHPZFJ0LWOKCHTHQMWAOZMX40VQV0S3PMZKNUMYZGHUP4WJ&v=20160524&ll=40.7,-74&"
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.cachePolicy = .UseProtocolCachePolicy
        request.timeoutInterval = 10.0
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                
                let httpResponse = response as? NSHTTPURLResponse
                let statusCode = httpResponse?.statusCode
                
                if statusCode == 200 {
                    print("Get Data Success")
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        print(json)
                    } catch {
                        print("Error with Data")
                    }
                }
            }
        })
        
        dataTask.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
