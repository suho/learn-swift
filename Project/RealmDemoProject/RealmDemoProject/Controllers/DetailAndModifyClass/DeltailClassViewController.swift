//
//  DeltailClassViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class DeltailClassViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var facultyTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberOfStudents: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var viewStudentsButton: UIButton!
    @IBOutlet weak var deleteClassButton: UIButton!

    var classOfStudents = Class()

    var isUpdateClass = false

    var modifyButton = UIBarButtonItem()

    let imagePicker = UIImagePickerController()

    var image: UIImage! = nil

    let notificationCenter = NSNotificationCenter.defaultCenter()

    var indexPathClass = NSIndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Class"
        self.imagePicker.delegate = self
        self.setDataUI()
        self.setModifyButtonUI()
        self.setUpNotificationCenter()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setAvatarUI()
    }

    // MARK: Set Up Notification Center
    func setUpNotificationCenter() {
        self.notificationCenter.addObserver(self, selector: #selector(self.updateInfomation), name: NotificationCenterKey.addNewStudent, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(self.updateInfomation), name: NotificationCenterKey.deleteStudent, object: nil)
    }

    @IBAction func viewStudentsAction(sender: AnyObject) {
        let studentsViewController = StudentsViewController(nibName: "StudentsViewController", bundle: nil)
        studentsViewController.classOfStudents = self.classOfStudents
        studentsViewController.indexPathClass = self.indexPathClass
        self.navigationController?.pushViewController(studentsViewController, animated: true)
    }

    @IBAction func addImageAction(sender: AnyObject) {

        let addImageAlertController = UIAlertController(title: "Choose How You Would Like To Add Image", message: "", preferredStyle: .ActionSheet)
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in

        }
        let takePictureAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { (action) in

            self.openCamera()
        }
        let choosePictureAlertAction = UIAlertAction(title: "Choose Frome Camera Roll", style: .Default) { (action) in

            self.openCameraRool()
        }

        addImageAlertController.addAction(cancelAlertAction)
        addImageAlertController.addAction(takePictureAlertAction)
        addImageAlertController.addAction(choosePictureAlertAction)
        self.navigationController?.presentViewController(addImageAlertController, animated: true, completion: nil)
    }

    @IBAction func deleteClassAction(sender: AnyObject) {

        let deleteClassAlertController = UIAlertController(title: "Do You Want To Delete This Class", message: "", preferredStyle: .ActionSheet)
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        let yesAlertAction = UIAlertAction(title: "Yes", style: .Destructive) { (action) in
            self.deleteClass()
        }
        deleteClassAlertController.addAction(cancelAlertAction)
        deleteClassAlertController.addAction(yesAlertAction)
        self.navigationController?.presentViewController(deleteClassAlertController, animated: true, completion: nil)
    }

    // MARK: DeleterClass
    func deleteClass() {
        for student in self.classOfStudents.students {
            let imageNameToDelete = student.imageName
            RealmManager.sharedInstance.deleteObject(student)
            FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
        }

        let imageNameToDelete = classOfStudents.imageName
        RealmManager.sharedInstance.deleteObject(classOfStudents)
        FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
        self.navigationController?.popViewControllerAnimated(true)
        self.notificationCenter.postNotificationName(NotificationCenterKey.deleteClass, object: nil,
            userInfo: ["indexPathClass": self.indexPathClass])
    }

    // MARK: Save Information Of Class
    func saveUpdateClass() {

        if self.checkValid() {

            do {
                let realm = try Realm()
                try realm.write({
                    self.changeInformationClass()
                })

            } catch let error as NSError {
                print(error.localizedDescription)
            }

            RealmManager.sharedInstance.updateObjectWithPrimaryKeys(self.classOfStudents)
            self.notificationCenter.postNotificationName(NotificationCenterKey.modifyClass, object: nil,
                userInfo: ["indexPathClass": self.indexPathClass])

        } else {
            self.setDataUI()
        }

    }

    // MARK: Change Information Of Class
    func changeInformationClass() {
        self.classOfStudents.facultyName = self.facultyTextField.text!
        self.classOfStudents.nameClass = self.nameTextField.text!

        if let image = self.image {
            let imageNameToDelete = self.classOfStudents.imageName
            self.classOfStudents.imageName = self.saveImage(image)
            FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
        }
    }

    // MARK: Update Information When Add New Student
    func updateInfomation() {
        do {
            let realm = try Realm()
            let classObj = realm.objects(Class).filter("idClass = '\(self.classOfStudents.idClass)'").first
            if let numberStudents = classObj?.students.count {
                self.numberOfStudents.text = "\(numberStudents)"
            }
        } catch {
            print("Realm Have Error!!")
        }
    }

    // MARK: Set Avatar UI
    func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.clipsToBounds = true
    }

    // MARK: Set Data UI
    func setDataUI() {
        self.addImageButton.hidden = true
        self.facultyTextField.text = classOfStudents.facultyName
        self.nameTextField.text = classOfStudents.nameClass
        self.numberOfStudents.text = "\(classOfStudents.students.count)"
        if !classOfStudents.imageName.isEmpty {
            self.avatarImageView.image = FileManager.sharedInstance.loadFile(classOfStudents.imageName, typeDirectory: .CachesDirectory)
        }
    }

    // MARK: Set Modify Button Of Navigation Bar
    func setModifyButtonUI() {
        let image = self.isUpdateClass ? UIImage(named: "Checked") : UIImage(named: "Edit")
        modifyButton = UIBarButtonItem(image: image, style: .Done, target: self, action: #selector(DeltailClassViewController.modifyAction))
        self.navigationItem.rightBarButtonItem = modifyButton
    }

    // MAKR: Open Modify Action
    func modifyAction() {

        if self.isUpdateClass {
            self.saveUpdateClass()

            self.isUpdateClass = false
        } else {

            self.isUpdateClass = true

        }
        self.activeModify(!isUpdateClass)
        self.setModifyButtonUI()

    }

    func activeModify(isUpdate: Bool) {
        self.addImageButton.hidden = isUpdate
        self.facultyTextField.enabled = !isUpdate
        self.nameTextField.enabled = !isUpdate
        self.viewStudentsButton.enabled = isUpdate
        self.deleteClassButton.enabled = isUpdate
    }

    // MARK: Check Valid
    private func checkValid() -> Bool {
        guard let _ = self.facultyTextField.text where self.facultyTextField.text != nil && self.facultyTextField.text != "" else {
            return false
        }

        guard let _ = self.nameTextField.text where self.nameTextField.text != nil && self.nameTextField.text != "" else {
            return false
        }

        return true
    }

    // MARK: Save Image

    func saveImage(image: UIImage) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy_hh_mm_ss"
        let filename = "\(dateFormatter.stringFromDate(NSDate())).png"
        FileManager.sharedInstance.saveFile(image, name: filename, typeDirectory: .CachesDirectory)
        return filename
    }

}

//MARK: Image Picker Delegate
extension DeltailClassViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Open Camera To Get Picture
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.imagePicker.sourceType = .Camera
            presentViewController(self.imagePicker, animated: true, completion: nil)
        } else {
            print("No Camera")
        }

    }

    // MARK: Open Camera Roll To Choose Picture
    private func openCameraRool() {
        self.imagePicker.sourceType = .PhotoLibrary
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.avatarImageView.contentMode = .ScaleToFill
            self.avatarImageView.image = image
            self.image = image
        }
    }
}
