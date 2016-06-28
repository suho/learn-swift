//
//  HomeViewController.swift
//  Exercise5_MasterDetail_Update
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    var students = [Student]()
    
    let cellIdentifier = "ProfileCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
    
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.getDataFromPList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getDataFromPList() {
        let path = NSBundle.mainBundle().pathForResource("students", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        for student in dataArray! {
            let avatar = student.objectForKey("avatar") as! String
            let name = student.objectForKey("name") as! String
            let age = student.objectForKey("age") as! Int
            let gender = student.objectForKey("gender") as! Bool
            let dataStudent = Student(name: name, age: age, gender: gender, avatar: avatar, avatarPath: "")
            students.append(dataStudent)
        }
    }
    
    
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 116.5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! ProfileTableViewCell
        let student = students[indexPath.row]
        
        if student.avatar == "" {
            cell.avatar.image = UIImage(contentsOfFile: student.avatarPath)
        } else {
            cell.avatar.image = UIImage(named: student.avatar)
        }
        cell.name.text = student.name
        cell.age.text = "\(student.age)"
        cell.gender.text = (student.gender) ? "Male" : "Female"
        
        if cell.gender.text == "Male" {
            cell.gender.textColor = UIColor.brownColor()
        } else {
            cell.gender.textColor = UIColor.grayColor()
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        return cell
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let detailView = DetailProfileViewController(nibName: "DetailProfileViewController", bundle: nil)
        detailView.indexRow = indexPath.row
        detailView.student = students[indexPath.row]
        detailView.delegate = self
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}

extension HomeViewController: DetailProfileDelegate {
    func dataStudentChange(indexRow: Int, student: Student) {
        self.students[indexRow] = student
        self.profileTableView.reloadData()
    }
}
