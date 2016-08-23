//
//  LocationMaps.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import MapKit

class LocationMaps: NSObject, MKAnnotation {
    var image: String = ""
    var imageData: UIImage = UIImage()
    var title: String? = ""
    var locationName: String = ""
    var discipline: String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 16.072056, longitude: 108.226926)

    init(image: String, imageData: UIImage, title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        super.init()
        self.image = image
        self.imageData = imageData
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
    }

    var subtitle: String? {
        return locationName
    }

    override init() {
        super.init()
    }
}