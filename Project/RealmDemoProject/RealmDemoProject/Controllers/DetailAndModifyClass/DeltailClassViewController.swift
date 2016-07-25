//
//  DeltailClassViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DeltailClassViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var facultyTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberOfStudents: UITextField!
    
    var classObject = Class()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Class"
        self.setDataUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setAvatarUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setModifyButtonUI()
    }
    
    @IBAction func viewStudentsAction(sender: AnyObject) {
        let studentsViewController = StudentsViewController(nibName: "StudentsViewController", bundle: nil)
        self.navigationController?.pushViewController(studentsViewController, animated: true)
    }
    @IBAction func deleteClassAction(sender: AnyObject) {
        
    }


    
    //MARK: Set Avatar UI
    func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.clipsToBounds = true
    }
    
    //MARK: Set Data UI
    func setDataUI() {
        self.facultyTextField.text = classObject.facultyName
        self.nameTextField.text = classObject.nameClass
        self.numberOfStudents.text = "\(classObject.students.count)"
        if !classObject.imageName.isEmpty {
            self.avatarImageView.image = FileManager.sharedInstance.loadFile(classObject.imageName, typeDirectory: .DocumentDirectory)
        }
    }
    
    //MARK: Set Modify Button Of Navigation Bar
    func setModifyButtonUI() {
        let modifyButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.activeModifyAction))
        modifyButton.image = UIImage(named: "Edit")
        self.navigationItem.rightBarButtonItem = modifyButton
    }
    
    //MAKR: Open Modify Action
    func activeModifyAction() {
        
    }

}
