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
    
    var classes: Results<Class>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DUT"
        self.classTableView.delegate = self
        self.classTableView.dataSource = self
        self.classTableView.registerNib(UINib(nibName: "CustomClassTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.reloadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setButtonRight()
        self.reloadTableView()
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
    
    //MARK: Reload Table View
    func reloadTableView() {
        do {
            let realm = try Realm()
            self.classes = realm.objects(Class)
            self.classTableView.reloadData()
        } catch {
            print("Realm Have Error!!")
        }
    }

}

//MARK: Set Up TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as? CustomClassTableViewCell
        let classObject = self.classes[indexPath.row]
        cell?.setData(classObject)
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailClassViewController = DeltailClassViewController(nibName: "DeltailClassViewController", bundle: nil)
        detailClassViewController.classObject = self.classes[indexPath.row]
        self.navigationController?.pushViewController(detailClassViewController, animated: true)
    }
    
}
