//
//  FavoriteTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class FavoriteTabBarViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favorites = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.registerNib(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "cellFavorite")
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.deleteAllFavoritesAciton))
        doneButton.image = UIImage(named: "delete-icon")
        doneButton.tintColor = UIColor.orangeColor()
        
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.favorites = self.getFavoriteData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        for i in 0..<self.favorites.count {
            self.favorites[i].isFavorite = true
        }

        self.favoriteTableView.reloadData()
    }
    
    func getFavoriteData() -> [Location] {
        
        let locations = HomeTabBarViewController.sharedInstance.readDataFromPlist()
        var result = [Location]()
        for location in locations {
            if location.isFavorite {
                result.append(location)
            }
        }
        return result
    }
    
    func deleteAllFavoritesAciton() {
        
//        self.showMessage("Delete All?", viewController: self)
        
        for i in 0..<self.favorites.count {
            self.favorites[i].isFavorite = false
        }
        self.favoriteTableView.reloadData()
    }
    
//    func showMessage(message: String, viewController: UIViewController) {
//        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        viewController.presentViewController(alertController, animated: true, completion: nil)
//    }
}

extension FavoriteTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellFavorite", forIndexPath: indexPath) as! FavoriteTableViewCell
        cell.setData(self.favorites[indexPath.row])
        cell.tintColor = UIColor.orangeColor()
        return cell
    }

    
}
