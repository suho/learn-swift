//
//  HomeViewController.swift
//  Exercise2_TableView_Name
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var names: [String]!
    let cellIdetifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names = ["Nguyễn Văn A", "Trần Văn B", "Phạm Thị C", "Trương Thị D", "Nguyễn Văn E", "Trần Văn F", "Phạm Thị G", "Trương Thị H", "Nguyễn Văn I", "Trần Văn J", "Phạm Thị K", "Trương Thị L"]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdetifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdetifier, forIndexPath: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You Select: \(names[indexPath.row])")
    }

}
