//
//  SettingTabBarViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class SettingTabBarViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    let sections = ["Account", "Peoples", "Logout"]
    let items = [["Username", "Email", "Profile Details"], ["Following", "Follower"], ["Logout"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        self.settingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension SettingTabBarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        cell.tintColor = UIColor.orangeColor()
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
    
        cell.userInteractionEnabled = false
        if (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row != 2) || (indexPath.section == 2) {
            cell.userInteractionEnabled = true
        }
        return cell
    }
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("Tapped \(indexPath.section), \(indexPath.row)")
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row != 2) || (indexPath.section == 2) {
            selectedCell.backgroundColor = UIColor.whiteColor()
            selectedCell.contentView.backgroundColor = UIColor.whiteColor()
        }
        switch indexPath.section {
        case 0:
            print("profile")
        case 1:
            print("follow")
        default:
            AppDelegate.sharedInstance.changeRootWhenLogout()
        }
    }
    
    
    
}