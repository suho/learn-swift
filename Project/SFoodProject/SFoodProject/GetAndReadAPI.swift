//
//  GetAndReadAPI.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/15/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

class ReadAPI {
    
    var venues: [Venue] = []
    var images: [UIImage] = []
    
    init() {
        //self.getDataFromAPI()
        
        self.getLocationFromAPI(16.070531, lng: 108.224599, limit: 10, offset: 0)
        
        //self.getImageFromAPI("4d4361d01928a35daba1ad70")
        
        //print("Get API..")
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
                        self.venues = result
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
                    
                    if let id = venue["id"] as? String {
                        objectVenue.id = id
                    }
                    
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
                        objectVenue.images = [UIImage(named: "food")!, UIImage(named: "cafe 61")!, UIImage(named: "The-CafeTNT")!]
                    } else {
                        objectVenue.images = [UIImage(named: "The-CafeTNT")!, UIImage(named: "cafe 61")!, UIImage(named: "food")!]
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
    
    func getLocationFromAPI(lat: Double, lng: Double, limit: Int, offset: Int) {
        
        let url: String = "https://api.foursquare.com/v2/venues/explore?oauth_token=3IHPZFJ0LWOKCHTHQMWAOZMX40VQV0S3PMZKNUMYZGHUP4WJ&v=20160524&ll=\(lat),\(lng)&limit=\(limit)&offset=\(offset)"
        
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
                        let venues = self.readLocationFromAPI(json)
                        self.venues = venues
                    } catch {
                        print("Error with Data")
                    }
                }
            }
        })
        dataTask.resume()

    }
    
    func readLocationFromAPI(data: AnyObject) -> [Venue] {
        var result = [Venue]()
        
        if let response = data["response"] as? NSDictionary {
            if let groups = response["groups"] as? NSArray {
                for group in groups {
                    if let items = group["items"] as? NSArray {
                        for item in items {
                            let objectVenue = Venue(id: "", images: [UIImage(named: "cafe 61")!], name: "", address: "", previewText: "", detailText: "", coordinates: (0, 0), isFavorite: false)
                            
                            if let venue = item["venue"] as? NSDictionary {
                                if let id = venue["id"] as? String {
                                    objectVenue.id = id
                                }
                                if let name = venue["name"] as? String {
                                    objectVenue.name = name
                                }
                                if let location = venue["location"] as? NSDictionary {
                                    if let address = location["address"] as? String {
                                        objectVenue.address += address
                                    }
                                    if let city = location["city"] as? String {
                                        if objectVenue.address != "" {
                                            objectVenue.address += ", \(city)"
                                        } else {
                                            objectVenue.address += city
                                        }
                                    }
                                    if let lat = location["lat"] as? Double {
                                        objectVenue.coordinates.0 = lat
                                    }
                                    if let lng = location["lng"] as? Double {
                                        objectVenue.coordinates.1 = lng
                                    }
                                }
                                if let categories = venue["categories"] as? NSArray {
                                    for category in categories {
                                        if let name = category["name"] as? String {
                                            objectVenue.previewText += " [\(name)] "
                                        }
                                    }
                                }
                            }
                            
                            if arc4random_uniform(20) % 3 == 0 {
                                objectVenue.isFavorite = true
                            }
                            
                            if let tips = item["tips"] as? NSArray {
                                for tip in tips {
                                    if let text = tip["text"] as? String {
                                        objectVenue.detailText += text
                                    }
                                }
                            }
                            result.append(objectVenue)
                        }
                    }
                }
            }
        }
        return result
    }
    
    
    func getImageFromAPI(idVenue: String) -> [UIImage] {
        
        var result: [UIImage] = []
        
        
        let url: String = "https://api.foursquare.com/v2/venues/\(idVenue)/photos?oauth_token=3IHPZFJ0LWOKCHTHQMWAOZMX40VQV0S3PMZKNUMYZGHUP4WJ&v=20160524"
        
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
                        
                        result = self.readImageFromAPI(json)
                        
                    } catch {
                        print("Error with Data")
                    }
                }
            }
        })
        dataTask.resume()
        
        return result
    }
    
    func readImageFromAPI(data: AnyObject) -> [UIImage] {
        var result: [UIImage] = []
        
        if let response = data["response"] as? NSDictionary {
            if let photos = response["photos"] as? NSDictionary {
                if let items = photos["items"] as? NSArray {
                    for item in items {
                        var url = ""
                        if let prefix = item["prefix"] as? String {
                            url += prefix + "300x300"
                        }
                        if let suffix = item["suffix"] as? String {
                            url += suffix
                        }
                        print(url)
                        
                        if let urlData = NSURL(string: url) {
                            if let data = NSData(contentsOfURL: urlData) {
                                result.append(UIImage(data: data)!)
                            }
                        }
                    }
                }
            }
            
        }
        print(result.count)
        return result
    }
    
    
    
}