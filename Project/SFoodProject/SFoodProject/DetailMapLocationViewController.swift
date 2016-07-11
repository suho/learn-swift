//
//  DetailMapLocationViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/8/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import MapKit

class DetailMapLocationViewController: UIViewController {
    
    @IBOutlet weak var detailMapView: MKMapView!
    
    var location = Location(images: ["food", "food", "food"], name: "Cafe 69", address: "69 Da Nang", previewText: "Cafe Xay", detailText: "Da Nang, Hai Chau, Nguyen Chi Thanh", coordinates: (0.00, 0.00), isFavorite: true)
    
    let regionRadius: CLLocationDistance = 2100
    
    let locationManager = CLLocationManager()
    
    var locationMap = LocationMaps()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail Map"
        
        let initialLocation = CLLocation(latitude: CLLocationDegrees(self.location.coordinates.0), longitude: CLLocationDegrees(self.location.coordinates.1))
        self.centerMapOnLocation(initialLocation)
        
        self.locationMap = LocationMaps(image: "\(self.location.images.first!)", title: "\(self.location.name)",
                                       locationName: "\(self.location.address)",
                                       discipline: "\(self.location.previewText)",
                                       coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(self.location.coordinates.0), longitude: CLLocationDegrees(self.location.coordinates.1)))
        
        self.detailMapView.addAnnotation(self.locationMap)
        self.detailMapView.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.detailMapView.showsUserLocation = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.detailMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func drawTwoPins(coordinateMyLocation: CLLocationCoordinate2D, coordinateFoodLocation: CLLocationCoordinate2D) {
        // 1.
        let myLocationPlacemark = MKPlacemark(coordinate: coordinateMyLocation, addressDictionary: nil)
        let foodLocationPlacemark = MKPlacemark(coordinate: coordinateFoodLocation, addressDictionary: nil)
        
        // 2.
        let myLocationMapItem = MKMapItem(placemark: myLocationPlacemark)
        let foodLocationMapItem = MKMapItem(placemark: foodLocationPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = myLocationMapItem
        directionRequest.destination = foodLocationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 3..
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.detailMapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveLabels)
            
            let rect = route.polyline.boundingMapRect
            //MKCoordinateRegionForMapRect(rect)
            
            //let coordinateRegion = MKCoordinateRegionMakeWithDistance(route.polyline.coordinate, 2000, 2000)
            
            self.detailMapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
}

extension DetailMapLocationViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    
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
                let buttonleft: UIButton = UIButton(type: UIButtonType.Custom)
                buttonleft.frame.size.width = view.frame.size.height
                buttonleft.frame.size.height = view.frame.size.height
                
                
                buttonleft.setImage(UIImage(named: "\(annotation.image)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
                view.leftCalloutAccessoryView = buttonleft
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orangeColor()
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    //MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let locationUser = (self.locationManager.location?.coordinate)!
        
        let latitudeUser = locationUser.latitude
        let longitudeUser = locationUser.longitude
        
        let latitudeLocation = self.locationMap.coordinate.latitude
        let longitudeLocation = self.locationMap.coordinate.longitude
        
        
        let coordinateMyLocation = CLLocationCoordinate2D(latitude: latitudeUser, longitude: longitudeUser)
        let coordinateFoodLocation = CLLocationCoordinate2D(latitude: latitudeLocation, longitude: longitudeLocation)
        
        self.drawTwoPins(coordinateMyLocation, coordinateFoodLocation: coordinateFoodLocation)
    }
    
}

