//
//  Location.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

class Location {
    
    var id: String = ""
    var images: [UIImage] = []
    var name: String = ""
    var address: String = ""
    var previewText: String = ""
    var detailText: String = ""
    var coordinates: (Double, Double) = (0.0, 0.0)
    var isFavorite: Bool = false
    
    init(id: String, images: [UIImage], name: String, address: String, previewText: String, detailText: String, coordinates: (Double, Double), isFavorite: Bool) {
        self.images = images
        self.name = name
        self.address = address
        self.previewText = previewText
        self.detailText = detailText
        self.coordinates = coordinates
        self.isFavorite = isFavorite
    }
    
    init() {
    }
}