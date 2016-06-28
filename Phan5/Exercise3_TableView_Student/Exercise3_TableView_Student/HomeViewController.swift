//
//  HomeViewController.swift
//  Exercise3_TableView_Student
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var studentTableView: UITableView!
    
    var students = [Student]()
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentTableView.dataSource = self
        self.studentTableView.delegate = self
        //self.studentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        let student1 = Student(name: "John Smith", avatar: "1", age: 18, gender: "Male")
        students.append(student1)
        let student2 = Student(name: "Janes Beck", avatar: "2", age: 20, gender: "Female")
        students.append(student2)
        let student3 = Student(name: "Tom Cruise", avatar: "3", age: 21, gender: "Male")
        students.append(student3)
        let student4 = Student(name: "David J.", avatar: "4", age: 19, gender: "Male")
        students.append(student4)
        let student5 = Student(name: "Putin K.", avatar: "5", age: 10, gender: "Male")
        students.append(student5)
        let student6 = Student(name: "Janes Beck", avatar: "2", age: 20, gender: "Female")
        students.append(student6)
        let student7 = Student(name: "Tom Cruise", avatar: "3", age: 21, gender: "Male")
        students.append(student7)
        let student8 = Student(name: "David J.", avatar: "4", age: 19, gender: "Male")
        students.append(student8)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: self.cellIdentifier)
        }
        
        let student = students[indexPath.row]
        
        cell!.imageView?.image = UIImage(named: "\(student.avatar!)")
        
        cell!.textLabel?.text = "\(student.name!)"
        
        cell!.detailTextLabel?.text = "\(student.age!)\t\t\t\(student.gender!)"
        
        cell!.accessoryType = UITableViewCellAccessoryType.DetailButton
        

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You Select \(students[indexPath.row].name!)")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let screenHeigt = UIScreen.mainScreen().bounds.height
        return screenHeigt/7
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("You Tapped Detail Button Of \(students[indexPath.row].name!)")
    }

    

}
