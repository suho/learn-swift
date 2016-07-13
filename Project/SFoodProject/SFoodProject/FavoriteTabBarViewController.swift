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
        

        
        self.favorites = self.getFavoriteData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.deleteAllFavoritesAciton))
        deleteButton.image = UIImage(named: "delete-icon")
        deleteButton.tintColor = UIColor.orangeColor()
        
        self.navigationItem.rightBarButtonItem = deleteButton
        
        self.favorites = self.getFavoriteData()
        
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
        for i in 0..<self.favorites.count {
            self.favorites[i].isFavorite = false
        }
        self.favoriteTableView.reloadData()
    }
}

extension FavoriteTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellFavorite", forIndexPath: indexPath) as! FavoriteTableViewCell
        cell.setData(self.favorites[indexPath.row])
        cell.tintColor = UIColor.orangeColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailView = DetailLocationViewController(nibName: "DetailLocationViewController", bundle: nil)
        detailView.location = self.favorites[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action , indexPath) -> Void in
            self.editing = false
            self.favorites.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        shareAction.backgroundColor = UIColor.orangeColor()
        return [shareAction]
    }

    
}
