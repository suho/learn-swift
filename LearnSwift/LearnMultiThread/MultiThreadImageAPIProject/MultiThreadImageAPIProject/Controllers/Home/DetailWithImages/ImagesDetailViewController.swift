//
//  ImagesDetailViewController.swift
//  MultiThreadImageAPIProject
//
//  Created by Mylo Ho on 7/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CacheManager {
    static let sharedInstance = NSCache()
}

class ImagesDetailViewController: UIViewController {

    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    var venue = Venue()
    
    var images = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Images"
        
        self.setNumberOfImages()
        
        self.locationCollectionView.delegate = self
        self.locationCollectionView.dataSource = self
        self.locationCollectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "collectionViewCell")
        
        self.downloadAllImage(self.venue.imagesURL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNumberOfImages() {
        for _ in 0..<self.venue.imagesURL.count {
            self.images.append(UIImage())
        }
    }
    
    
    
    func downloadAllImage(urls: [String]) {
        
        for (index, url) in urls.enumerate() {
            
            if let image = CacheManager.sharedInstance.objectForKey(url) as? UIImage {
                
                self.images[index] = image
                
            } else {
                
                let request = APIRequest.getRequestWith("GET", url: url, parameter: nil)
                
                APIProcess.sharedInstance.connectAPI(request) { (data, error, message) in
                    
                    if !error {
                        let image = UIImage(data: data!)!
                        self.images[index] = image
                        CacheManager.sharedInstance.setObject(image, forKey: url)
                        
                        var indexPaths = [NSIndexPath]()
                        
                        indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
                        self.locationCollectionView.reloadItemsAtIndexPaths(indexPaths)
                        
                    }
                }
                
                
            }
            
            
        }
        
    }
    
    
}

extension ImagesDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as? CollectionViewCell
        
        cell?.image.image = self.images[indexPath.row]
        
        cell?.backgroundColor = UIColor.whiteColor()
        
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = UIScreen.mainScreen().bounds.size.width / 4
        
        return CGSize(width: width, height: width)
    }
    
}
