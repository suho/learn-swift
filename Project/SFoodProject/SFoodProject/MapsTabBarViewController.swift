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
    
    let readAPI = ReadAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Maps"
        
        self.locations = self.readAPI.locations
        
        let initialLocation = CLLocation(latitude: (self.locations.first?.coordinates.0)!, longitude: (self.locations.first?.coordinates.1)!)
        self.centerMapOnLocation(initialLocation)
        
        self.mapsView.delegate = self

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
}

extension MapsTabBarViewController: MKMapViewDelegate {
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? LocationMaps {
            var view: MKAnnotationView
            
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                
            view.canShowCallout = true

            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
            let buttonleft: UIButton = UIButton(type: UIButtonType.Custom)
            buttonleft.frame.size.width = view.frame.size.height
            buttonleft.frame.size.height = view.frame.size.height
            buttonleft.setImage(UIImage(named: annotation.image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
            view.leftCalloutAccessoryView = buttonleft
            
            view.image = UIImage(named: "Map Pin")
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
          //print("You Tapped Right")
            let locationMap = view.annotation as! LocationMaps
            for location in self.locations {
                
                let conditionLatitude = CLLocationDegrees(location.coordinates.0) == locationMap.coordinate.latitude
                let conditionLongitude = CLLocationDegrees(location.coordinates.1) == locationMap.coordinate.longitude
                
                if conditionLatitude && conditionLongitude {
                    let detailView = DetailLocationViewController(nibName: "DetailLocationViewController", bundle: nil)
                    detailView.location = location
                    self.navigationController?.pushViewController(detailView, animated: true)
                }
            }
            
            
        }
    }
}
