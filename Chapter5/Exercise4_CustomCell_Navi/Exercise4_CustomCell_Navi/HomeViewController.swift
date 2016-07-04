//
//  HomeViewController.swift
//  Exercise4_CustomCell_Navi
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profilesTableView: UITableView!
    var students = [Student]()
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        self.profilesTableView.delegate = self
        self.profilesTableView.dataSource = self
        self.profilesTableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        
        self.readDateFromPlist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readDateFromPlist() {
        
        let path = NSBundle.mainBundle().pathForResource("students", ofType: "plist")
        
        let dataArray = NSArray(contentsOfFile: path!)
        
        for student in dataArray! {
            let avatar = student.objectForKey("avatar") as! String
            let name = student.objectForKey("name") as! String
            let age = student.objectForKey("age") as! Int
            let gender = student.objectForKey("gender") as! Bool
            let dataStudent = Student(name: name, avatar: avatar, age: age, gender: gender)
            students.append(dataStudent)
        }
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as! ProfileTableViewCell
        
        let student = students[indexPath.row]
        cell.avatarImage.image = UIImage(named: "\(student.avatar)")
        cell.nameLabel.text = student.name
        cell.ageLabel.text = "\(student.age)"
        cell.genderLabel.text = (student.gender) ? "Male" : "Female"
        
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.5
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let profileView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        profileView.student = students[indexPath.row]
        self.navigationController?.pushViewController(profileView, animated: true)
        
    }

}
