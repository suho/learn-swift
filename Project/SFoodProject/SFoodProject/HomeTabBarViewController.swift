//
//  HomeTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UIViewController {
    
    let readAPI = ReadAPI()
    
    var images: [Dictionary<String, UIImage>] = []
    
    var offset: Int = 0
    var limit: Int = 10
    
    @IBOutlet weak var locationTableView: UITableView!
    
    var locations = [Location]()
    
    class var sharedInstance: HomeTabBarViewController {
        struct Singleton {
            static let instance = HomeTabBarViewController()
        }
        return Singleton.instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        //self.locationTableView.backgroundColor = UIColor.darkGrayColor()
        
        self.readAPI.delegate = self
        self.readAPI.getLocationFromAPI(16.070531, lng: 108.224599, limit: self.limit, offset: self.offset)
//        if self.images.count == 0 {
//            self.progressBarDisplayer(true)
//        }
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        self.locationTableView.scrollEnabled = true
        self.locationTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil),forCellReuseIdentifier: "cellLocation")

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if endScrolling > scrollView.contentSize.height {
            self.offset += self.limit
            
//            self.locationTableView.scrollEnabled = false
//            self.locationTableView.userInteractionEnabled = false
//            
//            self.runAfterDelay(1) {
//                self.locationTableView.scrollEnabled = true
//                self.locationTableView.userInteractionEnabled = true
//            }
            
            self.readAPI.getLocationFromAPI(16.070531, lng: 108.224599, limit: self.limit, offset: self.offset)
        }
        
        
        
    }
    
    
    
//    func readDataFromPlist() -> [Location] {
//        let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
//        let locations = NSArray(contentsOfFile: path!)
//        
//        var result = [Location]()
//        
//        for location in locations! {
//            let images = location.objectForKey("images") as! NSArray
//            var imageData: [UIImage] = []
//            for image in images {
//                imageData.append(UIImage(named: image as! String)!)
//            }
//            let name = location.objectForKey("name") as! String
//            let address = location.objectForKey("address") as! String
//            let previewText = location.objectForKey("previewText") as! String
//            let detailText = location.objectForKey("detailText") as! String
//            let coordinates = location.objectForKey("coordinates") as! NSDictionary
//            let coordinatesX = coordinates.objectForKey("x") as! Double
//            let coordinatesY = coordinates.objectForKey("y") as! Double
//            let coordinate = (coordinatesX, coordinatesY)
//            let isFavorite = location.objectForKey("isFavorite") as! Bool
//            
//            let dataLocation = Location(id: "", images: imageData, name: name, address: address, previewText: previewText, detailText: detailText, coordinates: coordinate, isFavorite: isFavorite)
//            result.append(dataLocation)
//        }
//        
//        return result
//    }
    
    var messageFrame = UIView()
    
    func progressBarDisplayer(indicator: Bool) {
        
        var activityIndicator = UIActivityIndicatorView()
        messageFrame = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: messageFrame.frame.size.width/2 - 25, y: messageFrame.frame.size.height/2 - 25, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        view.addSubview(messageFrame)
    }

}

extension HomeTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellLocation", forIndexPath: indexPath) as! LocationTableViewCell
        
        var imageData = UIImage(named: "cafe 61")!
        
        if self.images.count == self.locations.count {
            //imageData = self.images[indexPath.row]
            
            for image in self.images {
                if let data = image[locations[indexPath.row].id] {
                    imageData = data
                }
            }
            
//            self.messageFrame.removeFromSuperview()
        }
        
        cell.setData(locations[indexPath.row], image: imageData)
        cell.tintColor = UIColor.orangeColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailView = DetailLocationViewController(nibName: "DetailLocationViewController", bundle: nil)
        detailView.location = locations[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}

extension HomeTabBarViewController: ReadAPIDelegate {
    
    func sendImages(id: String, _ image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), {
            if self.images.count < self.locations.count {
                self.images.append(Dictionary(dictionaryLiteral: (id, image)))
                print(self.images.count)
                self.locationTableView.reloadData()
            }
            
        })
    }
    func sendObject(venues: Venue) {
        dispatch_async(dispatch_get_main_queue(), {
            self.locations.append(venues)
            self.locationTableView.reloadData()
        })
    }
    
    func sendAllImages(images: [UIImage]) {
        return
    }
}























