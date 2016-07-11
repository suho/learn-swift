//
//  FollowingViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/11/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController {
    @IBOutlet weak var followingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Following"
        
        self.followingTableView.delegate = self
        self.followingTableView.dataSource = self
        self.followingTableView.registerNib(UINib(nibName:"FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: "cellFollowing")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellFollowing", forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailView = DetailFollowViewController(nibName: "DetailFollowViewController", bundle: nil)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
