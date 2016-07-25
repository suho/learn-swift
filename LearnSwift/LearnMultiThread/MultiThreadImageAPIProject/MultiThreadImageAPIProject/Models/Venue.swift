//
//  Venue.swift
//  MultiThreadImageAPIProject
//
//  Created by Mylo Ho on 7/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

typealias DownloadImageCompletion = (UIImage) -> (Void)

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
    
    static func getVenueFromJson(json: NSDictionary) -> Venue? {
        var venue: Venue?
        var location: Location?
        
        if let venueDictionary = json["venue"] as? NSDictionary {
            
            let id = venueDictionary["id"] as? String ?? ""
            let name = venueDictionary["name"] as? String ?? ""
            
            if let locationDictionary = venueDictionary["location"] as? NSDictionary {
                
                let address = locationDictionary["address"] as? String ?? ""
                let latitude = locationDictionary["lat"] as? Double ?? 0
                let longtitude = locationDictionary["lng"] as? Double ?? 0
                
                location = Location(address: address, latitude: latitude, longtitude: longtitude)
                
            }
            
            venue = Venue(id: id, name: name, location: location)

        }
        return venue
    }
    
    static func getImagesFromJson(json: NSDictionary) -> [String] {
        
        var imagesURL = [String]()
        
        if let items = json.objectForKey("items") as? NSArray {
            
            for item in items {
                
                let prefix = item.objectForKey("prefix") as? String ?? ""
                let suffix = item.objectForKey("suffix") as? String ?? ""
                
                let imageURL = "\(prefix)\(APIStringURL.imagesSizeCustom)\(suffix)"
                imagesURL.append(imageURL)
            }
        }
        
        return imagesURL
    }
    
    static func downloadImage(completion:DownloadImageCompletion) {
        //completion(
    }
    
    
    
    
}