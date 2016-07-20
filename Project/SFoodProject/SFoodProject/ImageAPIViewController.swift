//
//  ImageAPIViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/18/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class ImageAPIViewController: UIViewController {

    @IBOutlet weak var imagesAPICollectionView: UICollectionView!
    
    var images: [UIImage] = []
    
    let readAPI = ReadAPI()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readAPI.getImageFromAPI("4d4361d01928a35daba1ad70")
        //self.readAPI.delegate = self
        self.images = self.readAPI.images
        
        self.imagesAPICollectionView.delegate = self
        self.imagesAPICollectionView.dataSource = self
        self.imagesAPICollectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationController?.navigationBarHidden = false
        self.imagesAPICollectionView.backgroundColor = UIColor.brownColor().colorWithAlphaComponent(0.3)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.progressBarDisplayer(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

extension ImageAPIViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.image.image = self.images[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return (self.imagesAPICollectionView.frame.size.width - 300)
    }
    

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let spacingHeight = UIScreen.mainScreen().bounds.height - 364
        let spacingWidth = self.imagesAPICollectionView.bounds.width - 300
        let top = spacingHeight/2
        return UIEdgeInsets(top: top, left: spacingWidth/2, bottom: top, right: spacingWidth/2)
    }
    
}

//extension ImageAPIViewController: ReadAPIDelegate {
//    func sendImages(images: [UIImage]) {
//        dispatch_async(dispatch_get_main_queue(), {
//            self.images = images
//            self.imagesAPICollectionView.reloadData()
//            self.messageFrame.removeFromSuperview()
//        })
//        
//    }
//    func sendObject(venues: [Venue]) {
//        return
//    }
//}