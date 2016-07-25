//
//  StudentsViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {

    @IBOutlet weak var studentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        self.studentsTableView.delegate = self
        self.studentsTableView.dataSource = self
        self.studentsTableView.registerNib(UINib(nibName: "CustomStudentTableViewCell", bundle: nil), forCellReuseIdentifier: "cellStudentsCustom")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setAddButtonUI()
    }
    
    //MARK: Set UI - Add Student Button
    func setAddButtonUI() {
        let addStudentButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.showViewAddStudent))
        addStudentButton.image = UIImage(named: "Add User Male")
        self.navigationItem.rightBarButtonItem = addStudentButton
    }
    
    //MARK: Show View Add Student
    func showViewAddStudent() {
        let addStudentViewController = AddStudentViewController(nibName: "AddStudentViewController", bundle: nil)
        self.navigationController?.pushViewController(addStudentViewController, animated: true)
    }
}

//MARK: Set UI TableView - Delegate And DataSource
extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cellStudentsCustom", forIndexPath: indexPath) as? CustomStudentTableViewCell
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailStudentViewController = DetailAndModifyStudentViewController(nibName: "DetailAndModifyStudentViewController", bundle: nil)
        self.navigationController?.pushViewController(detailStudentViewController, animated: true)
    }
}
