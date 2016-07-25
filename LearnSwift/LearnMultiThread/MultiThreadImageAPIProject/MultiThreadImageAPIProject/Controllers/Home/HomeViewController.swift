//
//  HomeViewController.swift
//  MultiThreadImageAPIProject
//
//  Created by Mylo Ho on 7/19/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var locationTableView: UITableView!
    
    var venues = [Venue]()
    
    let limit = 10
    var offset = 0
    
    var refreshCtrl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.title = "HOME"
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(refreshTableView), forControlEvents: .ValueChanged)
        
        
        self.locationTableView.registerNib(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        self.locationTableView.addSubview(self.refreshCtrl)
        
        self.getVenueFromAPI(self.limit, offset: self.offset, isReload: false, isRefresh: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.venues.count == 0 {
            self.progressBarDisplayer(true)
        }
        
    }
    
    func refreshTableView() {
        
        self.venues = []
        
        CacheManager.sharedInstance.cache.removeAllObjects()
        
        self.getVenueFromAPI(self.limit, offset: 0, isReload: false, isRefresh: true)
        
    }
    
    func getThumbnail(venue: Venue, index: Int) {
        let imagesURL = "\(APIStringURL.imagesPrefixURL)\(venue.id)\(APIStringURL.imagesSuffixURL)\(APIStringURL.tokenAPI)"
        
        let request = APIRequest.getRequestWith("GET", url: imagesURL, parameter: nil)
        
        APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
            if !error {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        if let response = json.objectForKey("response") as? NSDictionary {
                            if let photos = response.objectForKey("photos") as? NSDictionary {
                                
                                let url = Venue.getImagesFromJson(photos)
                                venue.imagesURL = url
                                
                                if venue.imagesURL.count > 0 {
                                    self.downloadImage(venue.imagesURL[0], index: index)
                                }
                            }
                        }
                    }
                } catch {
                }
            }
        }
    
    }
    
    
    
    func downloadImage(url: String, index: Int) {
        
        let request = APIRequest.getRequestWith("GET", url: url, parameter: nil)
        
        APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
            
            if !error {
                
                if self.venues.count > index {
                    let venue = self.venues[index]
                    venue.thumbnail = UIImage(data: data!)
                    var indexPaths = [NSIndexPath]()
                    indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
                    self.locationTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
                }
                
                
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

            let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
            
            if endScrolling >= scrollView.contentSize.height {
                
                self.offset += self.limit
                
                self.getVenueFromAPI(self.limit, offset: self.offset, isReload: true, isRefresh: false)
        }
        
        
    }
    
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
    
    
    func getVenueFromAPI(limit: Int, offset: Int, isReload: Bool, isRefresh: Bool) {
        
        let venuesURLAPI = "https://api.foursquare.com/v2/venues/explore?\(APIStringURL.tokenAPI)&ll=16.070531,108.224599&limit=\(limit)&offset=\(offset)"
        
        let request = APIRequest.getRequestWith("GET", url: venuesURLAPI, parameter: nil)
        
        APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in

            if error {
                print("Get Data From API Have Error: \(message)")
            } else {
                self.messageFrame.removeFromSuperview()
                do {
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        
                        if let response = json["response"] {
                            if let groups = response["groups"] as? NSArray {
                                for group in groups {
                                    if let items = group["items"] as? NSArray {
                                        
                                        for (index, item) in items.enumerate() {
                                            
                                            if let item = item as? NSDictionary {
                                                if let venue = Venue.getVenueFromJson(item) {
                                                    self.venues.append(venue)
                                                    if isReload {
                                                        let indexContinue = index + self.offset
                                                        self.getThumbnail(venue, index: indexContinue)
                                                    } else {
                                                        self.getThumbnail(venue, index: index)
                                                    }
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
            
            if isRefresh {
                if self.refreshCtrl.refreshing {
                    self.refreshCtrl.endRefreshing()
                }
            }
            
            self.locationTableView.reloadData()
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? LocationTableViewCell
        
        if self.venues.count > indexPath.row {
            let venue = self.venues[indexPath.row]
            
            cell?.nameLabel.text = venue.name
            
            cell?.addressLabel.text = venue.location?.address
            
            if venue.thumbnail != nil {
                cell?.thumbnail.image = venue.thumbnail
            } else {
                cell?.thumbnail.image = nil
            }
        }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagesDetail = ImagesDetailViewController(nibName: "ImagesDetailViewController", bundle: nil)
        if self.venues[indexPath.row].imagesURL != nil {
            imagesDetail.venue = self.venues[indexPath.row]
            self.navigationController?.pushViewController(imagesDetail, animated: true)
        }
    }
}
