//
//  CustomVenueTableViewCell.swift
//  DemoGcdApiDownloaderLoadmore
//
//  Created by Mylo Ho on 7/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CustomVenueTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameVenueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    
    func downloadImageFromURL(url: String) {
        
        //self.image = UIImage(named: "loading")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            if let image = CacheManager.sharedInstance.cache.objectForKey(url) as? UIImage {
                self.image = image
            } else {
                let request = APIRequest.getRequestWith("GET", url: url, parameter: nil)
                APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
                    dispatch_async(dispatch_get_main_queue()) {
                        if !error {
                            if let data = data {
                                let image = UIImage(data: data)!
                                CacheManager.sharedInstance.cache.setObject(image, forKey: url)
                                self.image = image
                            }
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    
}