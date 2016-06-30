//
//  HomeViewController.swift
//  Exercise8_TableView_SearchBar
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var studentsTableView: UITableView!
    
    var students = [Student]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredStudents = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Student"
        
        self.studentsTableView.delegate = self
        self.studentsTableView.dataSource = self
        self.studentsTableView.registerNib(UINib(nibName: "StudentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.readDateFromPlist()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        studentsTableView.tableHeaderView = searchController.searchBar
        
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
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredStudents = students.filter { student in
            return student.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        studentsTableView.reloadData()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            return filteredStudents.count
        }
        
        return self.students.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StudentTableViewCell
        
        let student: Student
        
        if searchController.active && searchController.searchBar.text != "" {
            student = filteredStudents[indexPath.row]
        } else {
            student = students[indexPath.row]
        }
        cell.avatar.image = UIImage(named: student.avatar)
        cell.name.text = student.name
        cell.age.text = "\(student.age)"
        cell.gender.text = (student.gender) ? "Male" : "Female"
        cell.gender.textColor = (student.gender) ? UIColor.brownColor() : UIColor.darkGrayColor()
        return cell
    }
    
}

extension HomeViewController: UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}




