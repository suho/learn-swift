//
//  Venue.swift
//  APIAndGoogleMaps
//
//  Created by Mylo Ho on 7/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class Location {
    
    var address = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init(address: String, latitude: Double, longitude: Double){
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
}

class Venue {
    var id = ""
    var name = ""
    var location: Location?
    var thumbnail: UIImage!
    var imagesURL: [String]!
    
    init(id: String, name: String, location: Location?) {
        self.id = id
        self.name = name
        self.location = location
    }
    
    init() {
        
    }
    
    static func getVenueFromJson(json: [String: AnyObject]) -> Venue? {
    
        var venue: Venue?
        var location: Location?
        
        if let venueDictionary = json["venue"] as? NSDictionary {
            
            let id = venueDictionary["id"] as? String ?? ""
            let name = venueDictionary["name"] as? String ?? ""
            
            if let locationDictionary = venueDictionary["location"] as? NSDictionary {
                
                let address = locationDictionary["address"] as? String ?? ""
                let latitude = locationDictionary["lat"] as? Double ?? 0
                let longitude = locationDictionary["lng"] as? Double ?? 0
                
                location = Location(address: address, latitude: latitude, longitude: longitude)
                
            }
            
            venue = Venue(id: id, name: name, location: location)
            
        }
        return venue
    }

}

extension Venue {
    
    func getImagesString(json: [String: AnyObject]) {
        
        var imagesURL = [String]()
        
        if let items = json["items"] as? [[String: AnyObject]] {
            
            for item in items {
                
                let prefix = item["prefix"] as? String ?? ""
                let suffix = item["suffix"] as? String ?? ""
                
                let imageURL = "\(prefix)\(APIStringURL.imagesSizeCustom)\(suffix)"
                
                imagesURL.append(imageURL)
            }
            
        }
        
        self.imagesURL = imagesURL
        
    }
    
    func getThumbnail(data: NSData) {
        if let image = UIImage(data: data) {
            self.thumbnail = image
        }
    }
    
}

class CacheManager {
    
    static let sharedInstance = CacheManager()
    
    let cache = NSCache()
    
    init() {
        self.cache.countLimit = 50
    }
}







