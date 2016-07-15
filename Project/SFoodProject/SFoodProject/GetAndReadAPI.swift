//
//  GetAndReadAPI.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/15/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class ReadAPI {
    
    //var locations = Venue(images: [""], name: "", address: "", previewText: "", detailText: "", coordinates: (0, 0), isFavorite: false)
    
    var locations: [Venue] = []
    
    init() {
        self.getDataFromAPI()
    }
    
    func getDataFromAPI() {
        
        var result = [Venue]()
        
        
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
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        
                        result = self.readDataFromAPI(json)
                        self.locations = result
                    } catch {
                        print("Error with Data")
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func readDataFromAPI(data: AnyObject) -> [Venue] {
        
        var result = [Venue]()
        
        if let response = data["response"] as? NSDictionary {
            if let venues = response["venues"] as? NSArray {
                for venue in venues {
                    
                    let objectVenue = Venue()
                    
                    if let name = venue["name"] as? String {
                        objectVenue.name = name
                    }
                    
                    
                    if let location = venue["location"] as? NSDictionary {
                        if let formattedAddress = location["formattedAddress"] as? NSArray {
                            var address = ""
                            for formattedAdd in formattedAddress {
                                address += formattedAdd as? String ?? ""
                            }
                            objectVenue.address = address
                        }
                        if let lat = location["lat"] as? Double {
                            objectVenue.coordinates.0 = lat
                        }
                        if let lng = location["lng"] as? Double {
                            objectVenue.coordinates.1 = lng
                        }
                        
                    }
                    
                    if arc4random_uniform(10) % 3 == 0 {
                        objectVenue.images = ["food", "cafe 61", "The-CafeTNT"]
                    } else {
                        objectVenue.images = ["The-CafeTNT", "cafe 61", "food"]
                    }
                    
                    objectVenue.isFavorite = false
                    objectVenue.previewText = "abc"
                    objectVenue.detailText = "abcxyz"
                    
                    result.append(objectVenue)
                }
            }
        }
        return result
    }
    
    
    
}