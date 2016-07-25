//
//  HomeViewController.swift
//  DemoGcdApiDownloaderLoadmore
//
//  Created by Mylo Ho on 7/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var venueTableView: UITableView!
    
    var venues = [Venue]()
    
    let limit = 20
    var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.setDataTableView()
        self.getVenuesFromAPI(self.limit, offset: self.offset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Set Data For TableView
    func setDataTableView() {
        self.venueTableView.registerNib(UINib(nibName: "CustomVenueTableViewCell", bundle: nil), forCellReuseIdentifier: "venueCell")
        self.venueTableView.delegate = self
        self.venueTableView.dataSource = self
    }
    
    func getVenuesFromAPI(limit: Int, offset: Int) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let venuesAPI = "https://api.foursquare.com/v2/venues/explore?\(APIStringURL.tokenAPI)&ll=16.070531,108.224599&limit=\(limit)&offset=\(offset)"
            let request = APIRequest.getRequestWith("GET", url: venuesAPI, parameter: nil)
            
            APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
                if error {
                    print("Get Data From API Have Error: \(message)")
                } else {
                    if let data = data {
                        Venue.getVenusFromAPI(data, complete: { (venues) in
                            dispatch_async(dispatch_get_main_queue()) {
                                self.venues = venues
                                print(self.venues.count)
                                self.venueTableView.reloadData()
                            }
                        })
                    }
                }
            }
            
        }
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if endScrolling >= scrollView.contentSize.height {
            
            self.offset += self.venues.count
            //self.getVenuesFromAPI(self.limit, offset: self.limit)
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as? CustomVenueTableViewCell
        
        let venue = self.venues[indexPath.row]
        cell?.nameVenueLabel.text = venue.name
            
        cell?.thumbnailImageView.downloadImageFromURL(venue.thumbnailString)

        return cell!
    }
}
