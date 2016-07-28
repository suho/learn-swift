//
//  StudentsViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class StudentsViewController: UIViewController {

    @IBOutlet weak var studentsTableView: UITableView!

    var students: List<Student>!

    var classOfStudents = Class()

    var indexPathClass = NSIndexPath()

    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        self.studentsTableView.delegate = self
        self.studentsTableView.dataSource = self
        self.studentsTableView.registerNib(UINib(nibName: "CustomStudentTableViewCell", bundle: nil), forCellReuseIdentifier: "cellStudentsCustom")
        self.loadTableView()
        self.setAddButtonUI()
        self.setUpNotificationCenter()
    }

    // MARK: Set Up Notification Center
    func setUpNotificationCenter() {
        self.notificationCenter.addObserver(self, selector: #selector(self.insertCell), name: NotificationCenterKey.addNewStudent, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.updateCell), name: NotificationCenterKey.modifyStudent, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.deleteCell), name: NotificationCenterKey.deleteStudent, object: nil)
    }

    // MARK: Set UI - Add Student Button
    func setAddButtonUI() {
        let image = UIImage(named: "Add User Male")
        let addStudentButton: UIBarButtonItem = UIBarButtonItem(image: image, style: .Done, target: self, action: #selector(self.showViewAddStudent))
        self.navigationItem.rightBarButtonItem = addStudentButton
    }

    // MARK: Show View Add Student
    func showViewAddStudent() {
        let addStudentViewController = AddStudentViewController(nibName: "AddStudentViewController", bundle: nil)
        addStudentViewController.classOfStudents = self.classOfStudents
        addStudentViewController.indexPathClass = self.indexPathClass
        self.navigationController?.pushViewController(addStudentViewController, animated: true)
    }

    // MARK: Load Table View
    func loadTableView() {
        do {
            let realm = try Realm()
            let classObj = realm.objects(Class).filter("idClass == '\(self.classOfStudents.idClass)'").first
            self.students = classObj?.students
        } catch {
            print("Realm Have Error!!")
        }
    }

    // MARK: Insert Cell To Table View
    func insertCell() {
        do {
            let realm = try Realm()
            let classObj = realm.objects(Class).filter("idClass == '\(self.classOfStudents.idClass)'").first
            self.students = classObj?.students
            self.studentsTableView.beginUpdates()
            var indexPaths = [NSIndexPath]()
            indexPaths.append(NSIndexPath(forRow: self.students.count - 1, inSection: 0))
            self.studentsTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Right)
            self.studentsTableView.endUpdates()

        } catch {
            print("Realm Have Error!!")
        }
    }

    // MARK: Delete Cell Of Table View
    func deleteCell(notification: NSNotification) {

        var indexPath = NSIndexPath()

        if let infoUser = notification.userInfo {
            if let index = infoUser["indexPathStudent"] as? NSIndexPath {
                indexPath = index
            }
        }

        do {
            let realm = try Realm()
            let classObj = realm.objects(Class).filter("idClass == '\(self.classOfStudents.idClass)'").first
            self.students = classObj?.students
        } catch {
            print("Realm Have Error!!")
        }

        self.studentsTableView.beginUpdates()
        var indexPaths = [NSIndexPath]()
        indexPaths.append(indexPath)
        self.studentsTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Left)
        self.studentsTableView.endUpdates()

    }

    // Update Cell
    func updateCell(notification: NSNotification) {
        var indexPath = NSIndexPath()
        if let infoUser = notification.userInfo {
            if let index = infoUser["indexPathStudent"] as? NSIndexPath {
                indexPath = index
            }
        }
        do {
            let realm = try Realm()
            let classObj = realm.objects(Class).filter("idClass == '\(self.classOfStudents.idClass)'").first
            self.students = classObj?.students
        } catch {
            print("Realm Have Error!!")
        }
        self.studentsTableView.beginUpdates()
        var indexPaths = [NSIndexPath]()
        indexPaths.append(indexPath)
        self.studentsTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        self.studentsTableView.endUpdates()
    }
}

//MARK: Set UI TableView - Delegate And DataSource
extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellStudentsCustom", forIndexPath: indexPath) as? CustomStudentTableViewCell
        let student = self.students[indexPath.row]
        cell?.setData(student)
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailStudentViewController = DetailAndModifyStudentViewController(nibName: "DetailAndModifyStudentViewController", bundle: nil)
        detailStudentViewController.student = self.students[indexPath.row]
        detailStudentViewController.indexPathStudent = indexPath
        detailStudentViewController.indexPathClass = self.indexPathClass
        self.navigationController?.pushViewController(detailStudentViewController, animated: true)
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let student = self.students[indexPath.row]
            let imageNameToDelete = student.imageName

            RealmManager.sharedInstance.deleteObject(student)
            FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
            self.notificationCenter.postNotificationName(NotificationCenterKey.deleteStudent, object: nil,
                userInfo: ["indexPathClass": self.indexPathClass, "indexPathStudent": indexPath])
        }
    }
}
