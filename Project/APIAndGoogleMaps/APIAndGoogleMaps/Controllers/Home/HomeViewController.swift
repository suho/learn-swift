//
//  HomeViewController.swift
//  APIAndGoogleMaps
//
//  Created by Mylo Ho on 7/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var mapPin: UIImageView!
    
    @IBOutlet weak var getNewButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    let zoomMap: Float = 14
    
    let limit = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.getNewButton.layer.cornerRadius = self.getNewButton.frame.size.height / 2
        self.getNewButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getNewLocationAction(sender: AnyObject) {
        
        let coordinateCenter = self.getCoordinateCenter()
        
        self.googleMapsView.clear()
        
        self.getVenueFromAPI(coordinateCenter, limit: self.limit, offset: 0)
        
        
    }
    
    func getVenueFromAPI(coordinateCenter: CLLocationCoordinate2D, limit: Int, offset: Int) {
        
        let venuesURLAPI = "https://api.foursquare.com/v2/venues/explore?\(APIStringURL.tokenAPI)&ll=\(coordinateCenter.latitude),\(coordinateCenter.longitude)&limit=\(limit)&offset=\(offset)"

        let request = APIRequest.getRequestWith("GET", url: venuesURLAPI, parameter: nil)
        
        APIProcess.sharedInstance.connectVenueAPI(request) { (data, error, message) in
            if error {
                print("Have Error")
            } else {
                do {
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                        
                        if let meta = json["meta"] as? [String: AnyObject] {
                            if let code = meta["code"] as? Int {
                                switch code {
                                    case 304, 400, 401, 403, 404, 406, 410, 420, 422, 429, 500, 502, 503, 504:
                                        print("Webservice Have Error!!!")
                                        return
                                    default:
                                        print("Webservice Not Error!!!")
                                }
                            }
                        }
                        
                        if let response = json["response"] {
                            if let groups = response["groups"] as? [[String: AnyObject]] {
                                for group in groups {
                                    if let items = group["items"] as? [[String: AnyObject]] {
                                        for item in items {
                                            
                                            if let venue = Venue.getVenueFromJson(item) {
                                                
                                                let coordinateTopLeft = self.getCoordinateTopLeft()
                                                
                                                let coordinateBottomRight = self.getCoordinateBottomRight()
                                                
                                                let isContentLatitude = (venue.location!.latitude < coordinateTopLeft.latitude) && (venue.location!.latitude > coordinateBottomRight.latitude)
                                                
                                                let isContentLongitude = (venue.location!.longitude > coordinateTopLeft.longitude) && (venue.location!.longitude < coordinateBottomRight.longitude)
                                                
                                                if isContentLatitude && isContentLongitude {
                                                    self.getImagesString(venue)
                                                }
                                                
                                                
                                                    
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("API Have Error!!")
                }
            }
        }
    }
    
    func getImagesString(venue: Venue) {
        
        let imagesURL = "\(APIStringURL.imagesPrefixURL)\(venue.id)\(APIStringURL.imagesSuffixURL)\(APIStringURL.tokenAPI)"
        
        let request = APIRequest.getRequestWith("GET", url: imagesURL, parameter: nil)
        
        APIProcess.sharedInstance.connectVenueAPI(request) { (data, error, message) in
            if !error {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                        if let response = json["response"] as? [String: AnyObject] {
                            if let photos = response["photos"] as? [String: AnyObject] {
                                venue.getImagesString(photos)
                                
                                if venue.imagesURL.count > 0 {
                                    self.downloadThumbnail(venue)
                                }
                                
                            }
                        }
                    }
                } catch {
                    print("Have Error With JSON")
                }
            }
        }
        
    }
    
    func downloadThumbnail(venue: Venue) {
        
        if let _ = CacheManager.sharedInstance.cache.objectForKey(venue.imagesURL[0]) {
            
        } else {
            let request = APIRequest.getRequestWith("GET", url: venue.imagesURL[0], parameter: nil)
            
            APIProcess.sharedInstance.connectVenueAPI(request) { (data, error, message) in
                
                if !error {
                    
                    if let data = data {
                        venue.getThumbnail(data)
                    }
                    CacheManager.sharedInstance.cache.setObject("", forKey: venue.imagesURL[0])
                    self.addMarker(venue)
                    
                }
            }
        }
        
        
        
    }
    
    func addMarker(venue: Venue) {
        
        let market = GMSMarker()
        market.position = CLLocationCoordinate2DMake(venue.location!.latitude, venue.location!.longitude)
        market.title = venue.name
        market.icon = self.resizeImage(venue.thumbnail, targetSize: CGSizeMake(50, 50)).roundedImage
        market.map = self.googleMapsView
        
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
   
    func getCoordinateCenter() -> CLLocationCoordinate2D {
        
        let point: CGPoint = self.googleMapsView.center
        
        return self.googleMapsView.projection.coordinateForPoint(point)
        
    }
    
    func getCoordinateTopLeft() -> CLLocationCoordinate2D {
        
        let topLeftPoint: CGPoint = self.googleMapsView.bounds.origin
        
        return self.googleMapsView.projection.coordinateForPoint(topLeftPoint)
        
    }
    
    func getCoordinateBottomRight() -> CLLocationCoordinate2D {
        
        let bottomRightPointX: CGFloat = self.googleMapsView.bounds.origin.x + self.googleMapsView.bounds.size.width
        
        let bottomRightPointY: CGFloat = self.googleMapsView.bounds.origin.y + self.googleMapsView.bounds.size.height
        
        let bottomRightPoint: CGPoint = CGPointMake(bottomRightPointX, bottomRightPointY)
        
        return self.googleMapsView.projection.coordinateForPoint(bottomRightPoint)
    }
    
    

}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            self.googleMapsView.myLocationEnabled = true
            self.googleMapsView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.googleMapsView.camera = GMSCameraPosition(target: location.coordinate, zoom: self.zoomMap, bearing: 0, viewingAngle: 0)
            self.locationManager.stopUpdatingLocation()
        }
    }
}


