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
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        self.settingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        
        self.user = self.getUserById(AppDelegate.sharedInstance.idUser)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.settingsTableView.reloadData()
    }
    
    func getUserById(idUser: Int) -> User {
        var result = User()
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist")
        let users = NSArray(contentsOfFile: path!)
        
        
        for user in users! {
            let _idUser = user.objectForKey("id") as! Int
            if _idUser == idUser {
                let _name = user.objectForKey("name") as! String
                let _username = user.objectForKey("username") as! String
                let _password = user.objectForKey("password") as! String
                let _email = user.objectForKey("email") as! String
                let _phone = user.objectForKey("phone") as! String
                let _avatar = user.objectForKey("avatar") as! String
                let _gender = user.objectForKey("gender") as! Bool
                let _age = user.objectForKey("age") as! Int
                result = User(idUser: _idUser, fullName: _name, username: _username, password: _password, email: _email, phone: _phone, avatar: _avatar, gender: _gender, age: _age)
            }
        }
        return result
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        cell.tintColor = UIColor.orangeColor()
        
        var detailUser = ""
        if indexPath.section == 0 && indexPath.row < 2 {
            if indexPath.row == 0 {
                detailUser = ": \(self.user.fullName)"
            }
            if indexPath.row == 1 {
                detailUser = ": \(self.user.email)"
            }
        }
        cell.textLabel?.text = "\(self.items[indexPath.section][indexPath.row])\(detailUser)"
        cell.userInteractionEnabled = false
        if (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row != 2) || (indexPath.section == 2) {
            cell.userInteractionEnabled = true
            cell.accessoryType = .DisclosureIndicator
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
            //print("profile")
            let detailProfile = DetailProfileViewController(nibName: "DetailProfileViewController", bundle: nil)
            self.navigationController?.pushViewController(detailProfile, animated: true)
        case 1:
            print("follow")
        default:
            AppDelegate.sharedInstance.changeRootWhenLogout()
        }
    }
    
    
    
}