//
//  MapsTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import MapKit

class MapsTabBarViewController: UIViewController {

    @IBOutlet weak var mapsView: MKMapView!
    
    
    let regionRadius: CLLocationDistance = 1500
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Maps"
        let initialLocation = CLLocation(latitude: 16.072056, longitude: 108.226926)
        self.centerMapOnLocation(initialLocation)
        
        let locationMap = LocationMaps(image: "food", title: "Cầu Sông Hàn",
                              locationName: "Đà Nẵng",
                              discipline: "Cầu",
                              coordinate: CLLocationCoordinate2D(latitude: 16.072056, longitude: 108.226926))
        
        self.mapsView.addAnnotation(locationMap)
        self.mapsView.delegate = self
        
        self.readDataFromPlist()
        let annotations = self.getMapsAnnotations()
        self.mapsView.addAnnotations(annotations)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapsView.setRegion(coordinateRegion, animated: true)
    }
    
    func getMapsAnnotations() -> [LocationMaps] {
        var result = [LocationMaps]()
        let locations = self.locations
        for location in locations {
            let annotation = LocationMaps(image: location.images.first! ,title: location.name, locationName: location.address, discipline: "Coffe", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(location.coordinates.0), longitude: CLLocationDegrees(location.coordinates.1)))
            result.append(annotation)
        }
        return result
    }
    
    func readDataFromPlist() {
        let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
        let locations = NSArray(contentsOfFile: path!)
        
        for location in locations! {
            let images = location.objectForKey("images") as! NSArray
            let name = location.objectForKey("name") as! String
            let address = location.objectForKey("address") as! String
            let previewText = location.objectForKey("previewText") as! String
            let detailText = location.objectForKey("detailText") as! String
            let coordinates = location.objectForKey("coordinates") as! NSDictionary
            let coordinatesX = coordinates.objectForKey("x") as! Double
            let coordinatesY = coordinates.objectForKey("y") as! Double
            let coordinate = (coordinatesX, coordinatesY)
            let isFavorite = location.objectForKey("isFavorite") as! Bool
            
            let dataLocation = Location(images: images as! [String], name: name, address: address, previewText: previewText, detailText: detailText, coordinates: coordinate, isFavorite: isFavorite)
            self.locations.append(dataLocation)
        }
    }
    

}

extension MapsTabBarViewController: MKMapViewDelegate {
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? LocationMaps {
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
                let buttonleft: UIButton = UIButton(type: UIButtonType.Custom)
                buttonleft.frame.size.width = view.frame.size.height
                buttonleft.frame.size.height = view.frame.size.height
                buttonleft.setImage(UIImage(named: annotation.image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
                view.leftCalloutAccessoryView = buttonleft
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            print("You Tapped Right")
        } else {
            print("You Tapped Left")
        }
        
    }
}
