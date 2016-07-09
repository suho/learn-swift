//
//  DetailLocationViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/8/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import MapKit

class DetailLocationViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var nameOfLocation: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var previewText: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var mapLocationView: MKMapView!
    
    var location = Location(images: ["food", "food", "food"], name: "Cafe 69", address: "69 Da Nang", previewText: "Cafe Xay", detailText: "Da Nang, Hai Chau, Nguyen Chi Thanh", coordinates: (0.00, 0.00), isFavorite: true)
    
    var favoriteButton: UIBarButtonItem!
    
    let regionRadius: CLLocationDistance = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        self.imagesCollectionView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        
        self.nameOfLocation.text = self.location.name
        self.address.text = self.location.address
        self.previewText.text = self.location.previewText
        self.detailText.text = self.location.detailText
        
        self.favoriteButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.changeFavorite))
        if self.location.isFavorite {
            self.favoriteButton.image = UIImage(named: "orange-star")
        } else {
            self.favoriteButton.image = UIImage(named: "no-star")
        }
        //self.favoriteButton.tintColor = UIColor.orangeColor()
        
        self.navigationItem.rightBarButtonItem = self.favoriteButton
        
        self.imagesCollectionView.delegate = self
        self.imagesCollectionView.dataSource = self
        self.imagesCollectionView.registerNib(UINib(nibName: "LocationDetailCollectionViewCell", bundle: nil) ,forCellWithReuseIdentifier: "cell")
        
        let initialLocation = CLLocation(latitude: CLLocationDegrees(self.location.coordinates.0), longitude: CLLocationDegrees(self.location.coordinates.1))
        self.centerMapOnLocation(initialLocation)
        let locationMap = LocationMaps(image: "\(self.location.images.first!)", title: "\(self.location.name)",
                                       locationName: "\(self.location.address)",
                                       discipline: "\(self.location.previewText)",
                                       coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(self.location.coordinates.0), longitude: CLLocationDegrees(self.location.coordinates.1)))
        self.mapLocationView.addAnnotation(locationMap)
        self.mapLocationView.delegate = self
        self.mapLocationView.scrollEnabled = false
        self.mapLocationView.zoomEnabled = false
        
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        if touch.view == self.mapLocationView {
            print("")
        }
    }
    
    func changeFavorite() {
        if self.location.isFavorite {
            self.location.isFavorite = false
            self.favoriteButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.changeFavorite))
            self.favoriteButton.image = UIImage(named: "no-star")
            self.navigationItem.rightBarButtonItem = self.favoriteButton
        } else {
            self.location.isFavorite = true
             self.favoriteButton = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.changeFavorite))
            self.favoriteButton.image = UIImage(named: "orange-star")
            self.navigationItem.rightBarButtonItem = self.favoriteButton
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapLocationView.setRegion(coordinateRegion, animated: true)
    }

}

extension DetailLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.location.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LocationDetailCollectionViewCell
        
        cell.image.image = UIImage(named: "\(self.location.images[indexPath.row])")

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = self.imagesCollectionView.frame.size.height - (self.imagesCollectionView.frame.size.height/6)
        
        return CGSize(width: size , height: size)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You Selected \(indexPath.row)")
    }
}

extension DetailLocationViewController: MKMapViewDelegate {
    
    
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
                
                
                buttonleft.setImage(UIImage(named: "\(annotation.image)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState:UIControlState.Normal)
                view.leftCalloutAccessoryView = buttonleft
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let detailMapView = DetailMapLocationViewController(nibName: "DetailMapLocationViewController", bundle: nil)
        detailMapView.location = self.location
        self.navigationController?.pushViewController(detailMapView, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let detailMapView = DetailMapLocationViewController(nibName: "DetailMapLocationViewController", bundle: nil)
        detailMapView.location = self.location
        self.navigationController?.pushViewController(detailMapView, animated: true)
    }
    
}


