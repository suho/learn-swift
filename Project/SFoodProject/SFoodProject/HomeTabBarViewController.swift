//
//  HomeTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UIViewController {
    
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
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        self.locationTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil),forCellReuseIdentifier: "cellLocation")
        
        self.locations = self.readDataFromPlist()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.locations = self.readDataFromPlist()
        self.locationTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readDataFromPlist() -> [Location] {
        let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
        let locations = NSArray(contentsOfFile: path!)
        
        var result = [Location]()
        
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
            result.append(dataLocation)
        }
        
        return result
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
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellLocation", forIndexPath: indexPath) as! LocationTableViewCell
        cell.setData(locations[indexPath.row])
        cell.tintColor = UIColor.orangeColor()
        return cell
    }

}

























