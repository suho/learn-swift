//
//  FavoriteTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteTabBarViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!

    var favorites: Results<VenueRealm>!

    var images: [Dictionary<String, UIImage>] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"

        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        self.favoriteTableView.registerNib(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "cellFavorite")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.setUpDeleteButton()

        do {
            let realm = try Realm()
            self.favorites = realm.objects(VenueRealm)
            self.favoriteTableView.reloadData()
        } catch let error as NSError {
            print(error)
        }

    }

    func setUpDeleteButton() {
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.deleteAllFavoritesAciton))
        deleteButton.image = UIImage(named: "delete-icon")
        deleteButton.tintColor = UIColor.orangeColor()

        self.navigationItem.rightBarButtonItem = deleteButton
    }

    func deleteAllFavoritesAciton() {
        do {
            let realm = try Realm()
            try realm.write({
                realm.deleteAll()
            })
        } catch let error as NSError {
            print(error)
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

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let detailView = DetailLocationViewController(nibName: "DetailLocationViewController", bundle: nil)
//        detailView.location = self.favorites[indexPath.row]
//        self.navigationController?.pushViewController(detailView, animated: true)
//    }

//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action, indexPath) -> Void in
//            self.editing = false
//            self.favorites.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//        shareAction.backgroundColor = UIColor.orangeColor()
//        return [shareAction]
//    }

}
