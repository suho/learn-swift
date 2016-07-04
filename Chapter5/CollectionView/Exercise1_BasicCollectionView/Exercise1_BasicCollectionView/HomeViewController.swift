//
//  HomeViewController.swift
//  Exercise1_BasicCollectionView
//
//  Created by Mylo Ho on 7/3/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var basicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection View"
        
//        let bg = UIImageView(image: UIImage(named: "bg")!)
//        bg.contentMode = .ScaleAspectFit
//        bg.frame = UIScreen.mainScreen().bounds
//        
//        self.view.insertSubview(bg, atIndex: 0)
        
        self.basicCollectionView.delegate = self
        self.basicCollectionView.dataSource = self
        self.basicCollectionView.registerNib(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 51
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        if Int(arc4random_uniform(10)) % 2 == 0 {
            cell.image.image = UIImage(named: "abc")
        } else {
            cell.image.image = UIImage(named: "tree")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let random = CGFloat(arc4random_uniform(10) + 1)
        
        return CGSize(width: (UIScreen.mainScreen().bounds.size.width - 40)/random , height: (UIScreen.mainScreen().bounds.size.width - 40)/random)
  
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You Selected \(indexPath.row)")
    }
    

}
