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

    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DUT"
        self.loadData()
        self.setButtonRight()
        self.classTableView.delegate = self
        self.classTableView.dataSource = self
        self.classTableView.registerNib(UINib(nibName: "CustomClassTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.setUpNotificationCenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Set Up Notification Center
    func setUpNotificationCenter() {
        self.notificationCenter.addObserver(self, selector: #selector(self.insertCell), name: NotificationCenterKey.addNewClass, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.deleteCell), name: NotificationCenterKey.deleteClass, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.updateCell), name: NotificationCenterKey.modifyClass, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.updateCell), name: NotificationCenterKey.addNewStudent, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.updateCell), name: NotificationCenterKey.deleteStudent, object: nil)
    }

    // MARK: Set UI - Button Right of Navigation Bar
    func setButtonRight() {
        let image = UIImage(named: "Add List")
        let addClassButton: UIBarButtonItem = UIBarButtonItem(image: image, style: .Done, target: self, action: #selector(self.showAddClassView))
        self.navigationItem.rightBarButtonItem = addClassButton
    }

    // MARK: Add Class By Realm
    func showAddClassView() {
        let addClassViewController = AddClassViewController(nibName: "AddClassViewController", bundle: nil)
        self.navigationController?.pushViewController(addClassViewController, animated: true)
    }

    // MARK: Reload Data
    func loadData() {
        do {
            let realm = try Realm()
            self.classes = realm.objects(Class)
        } catch {
            print("Realm Have Error!!")
        }
    }

    // MARK: Insert Cell Onto Table
    func insertCell() {
        do {
            let realm = try Realm()
            self.classes = realm.objects(Class)
            self.classTableView.beginUpdates()
            var indexPaths = [NSIndexPath]()
            indexPaths.append(NSIndexPath(forRow: self.classes.count - 1, inSection: 0))
            self.classTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Right)
            self.classTableView.endUpdates()
        } catch {
            print("Realm Have Error!!")
        }

    }

    // MARK: Delete Cell Of Table View
    func deleteCell(notification: NSNotification) {

        var indexPath = NSIndexPath()

        if let infoUser = notification.userInfo {
            if let index = infoUser["indexPathClass"] as? NSIndexPath {
                indexPath = index
            }
        }

        do {
            let realm = try Realm()
            self.classes = realm.objects(Class)
        } catch {
            print("Realm Have Error!!")
        }
        self.classTableView.beginUpdates()
        var indexPaths = [NSIndexPath]()
        indexPaths.append(indexPath)
        self.classTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Left)
        self.classTableView.endUpdates()
    }

    // Update Cell

    func updateCell(notification: NSNotification) {
        var indexPath = NSIndexPath()
        if let infoUser = notification.userInfo {
            if let index = infoUser["indexPathClass"] as? NSIndexPath {
                indexPath = index
            }
        }
        do {
            let realm = try Realm()
            self.classes = realm.objects(Class)
        } catch {
            print("Realm Have Error!!")
        }
        self.classTableView.beginUpdates()
        var indexPaths = [NSIndexPath]()
        indexPaths.append(indexPath)
        self.classTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        self.classTableView.endUpdates()
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
        detailClassViewController.classOfStudents = self.classes[indexPath.row]
        detailClassViewController.indexPathClass = indexPath
        self.navigationController?.pushViewController(detailClassViewController, animated: true)
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {

            let classObj = self.classes[indexPath.row]

            for student in classObj.students {
                let imageNameToDelete = student.imageName
                RealmManager.sharedInstance.deleteObject(student)
                FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
            }

            let imageNameToDelete = classObj.imageName
            FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
            classObj.delete()

            self.loadData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }

}
