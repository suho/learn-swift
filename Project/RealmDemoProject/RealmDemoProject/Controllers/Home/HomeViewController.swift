//
//  HomeViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var classTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DUT"
        self.classTableView.delegate = self
        self.classTableView.dataSource = self
        self.classTableView.registerNib(UINib(nibName: "CustomClassTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setButtonRight()
    }
    
    //MARK: Set UI - Button Right of Navigation Bar
    func setButtonRight() {
        let addClassButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.showAddClassView))
        addClassButton.image = UIImage(named: "Add List")
        self.navigationItem.rightBarButtonItem = addClassButton
        
    }
    
    //MARK: Add Class By Realm
    func showAddClassView() {
        let addClassViewController = AddClassViewController(nibName: "AddClassViewController", bundle: nil)
        self.navigationController?.pushViewController(addClassViewController, animated: true)
    }

}

//MARK: Set Up TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as? CustomClassTableViewCell
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailClassViewController = DeltailClassViewController(nibName: "DeltailClassViewController", bundle: nil)
        self.navigationController?.pushViewController(detailClassViewController, animated: true)
    }
    
}
