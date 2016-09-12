//
//  HomeViewController.swift
//  YoutubeAPIProject
//
//  Created by Mylo Ho on 7/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.registerNib(UINib(nibName: "CustomSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 106
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as? CustomSearchTableViewCell
        if indexPath.row % 2 == 0 {
            cell?.titleVideoLabel.text = "CustomSearchTableViewCell CustomSearchTableViewCell CustomSearchTableViewCell"
        } else {
            cell?.titleVideoLabel.text = "CustomSearchTableViewCell"
        }

        return cell!
    }
}
