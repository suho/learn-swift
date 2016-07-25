//
//  Venue.swift
//  DemoGcdApiDownloaderLoadmore
//
//  Created by Mylo Ho on 7/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class Location {
    
    var address = ""
    var latitude: Double = 0.0
    var longtitude: Double = 0.0
    
    init(address: String, latitude: Double, longtitude: Double){
        self.address = address
        self.latitude = latitude
        self.longtitude = longtitude
    }
    
    
}

class CacheManager {
    
    static let sharedInstance = CacheManager()
    
    let cache = NSCache()
    
    init() {
        cache.countLimit = 100
    }
    
}

typealias completeDownloadThumbnailString = (thumnailString: String) -> Void
typealias completeDownloadVenues = (venues: [Venue]) -> Void

class Venue {
    var id = ""
    var name = ""
    var location: Location?
    var imagesURL: [String]!
    var thumbnailString: String!
    
    init(id: String, name: String, location: Location?) {
        self.id = id
        self.name = name
        self.location = location
    }
    
    init() {
        
    }
    
    static func getVenusFromAPI(data: NSData, complete: completeDownloadVenues){
        
        var venues = [Venue]()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            
            do {
                
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] ?? [:]
                
                let response = json["response"] as? [String: AnyObject] ?? [:]
                
                let groups = response["groups"] as? [[String: AnyObject]] ?? [[:]]
                
                for group in groups {
                    
                    let items = group["items"] as? [[String: AnyObject]] ?? [[:]]
                    
                    for item in items {
                        
                        if let venue = Venue.getVenueFromJson(item) {
                            venue.getImageStringFromAPI({ (thumnailString) in
                                venue.thumbnailString = thumnailString
                                venues.append(venue)
                                
                                dispatch_async(dispatch_get_main_queue()) { 
                                    complete(venues: venues)
                                }
                                
                            })
                        }
                    }
                    
                }
                
                
            } catch {
                print("API Have Error!!")
            }
        }
        
        
    }
    
    static func getVenueFromJson(json: [String: AnyObject]) -> Venue? {
        
        var venue: Venue?
        var location: Location?
        
        if let venueDictionary = json["venue"] as? [String: AnyObject] {
            
            let id = venueDictionary["id"] as? String ?? ""
            let name = venueDictionary["name"] as? String ?? ""
            
            if let locationDictionary = venueDictionary["location"] as? [String: AnyObject]  {
                
                let address = locationDictionary["address"] as? String ?? ""
                let latitude = locationDictionary["lat"] as? Double ?? 0
                let longtitude = locationDictionary["lng"] as? Double ?? 0
                
                location = Location(address: address, latitude: latitude, longtitude: longtitude)
                
            }
            
            venue = Venue(id: id, name: name, location: location)
            
        }
        
        return venue
    }
    
    func getImageStringFromAPI(complete: completeDownloadThumbnailString) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let imageStringAPI = "\(APIStringURL.imagesPrefixURL)\(self.id)/photos?\(APIStringURL.tokenAPI)&limit=1&offset=0"
            
            let request = APIRequest.getRequestWith("GET", url: imageStringAPI, parameter: nil)
            
            APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
                if error {
                    print("Get Data From API Have Error: \(message)")
                } else {
                    if let data = data {
                        let thumbnailString = self.getImageStringFromData(data)
                        complete(thumnailString: thumbnailString)
                        
                    }
                }
            }
        }
    }
    
    
    func getImageStringFromData(data: NSData) -> String {
        
        var result = ""
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] ?? [:]
                
            let response = json["response"] as? [String: AnyObject] ?? [:]
            
            let photos = response["photos"] as? [String: AnyObject] ?? [:]
            
            let items = photos["items"] as? [[String: AnyObject]] ?? [[:]]
                
            let prefix = items[0]["prefix"] as? String ?? ""
            let suffix = items[0]["suffix"] as? String ?? ""
                
            result = "\(prefix)\(APIStringURL.imagesSizeCustom)\(suffix)"
            
            
            
            
        } catch {
            print("JSON HAVE ERROR!!")
        }
        return result
    }
    
    func thread() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
            }
        }

    }

}
