//
//  DetailAndModifyStudentViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class DetailAndModifyStudentViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var deleteStudentButton: UIButton!

    var student = Student()

    var isUpdateStudent = false

    var modifyButton = UIBarButtonItem()

    let imagePicker = UIImagePickerController()

    var image: UIImage! = nil

    var indexPathStudent = NSIndexPath()

    var indexPathClass = NSIndexPath()

    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Student"
        self.imagePicker.delegate = self
        self.setDataUI()
        self.setModifyButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setAvatarUI()
    }

    // MARK: Set Up Notification Center
    func setUpNotification() {
        self.notificationCenter.addObserver(self, selector: nil, name: NotificationCenterKey.deleteStudent, object: nil)
        self.notificationCenter.addObserver(self, selector: nil, name: NotificationCenterKey.modifyStudent, object: nil)
    }

    @IBAction func deleteStudentAction(sender: AnyObject) {

        let deleteStudentAlertController = UIAlertController(title: "Do You Want To Delete This Class", message: "", preferredStyle: .ActionSheet)
        let cancelDeleteAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        let deleteAlertAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
            self.deleteStudent()
        }
        deleteStudentAlertController.addAction(cancelDeleteAlertAction)
        deleteStudentAlertController.addAction(deleteAlertAction)
        self.navigationController?.presentViewController(deleteStudentAlertController, animated: true, completion: nil)
    }

    // MARK: Delete Student
    func deleteStudent() {
        let imageNameToDelete = self.student.imageName

        RealmManager.sharedInstance.deleteObject(student)
        FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
        self.notificationCenter.postNotificationName(NotificationCenterKey.deleteStudent, object: nil,
            userInfo: ["indexPathClass": self.indexPathClass, "indexPathStudent": self.indexPathStudent])
        self.navigationController?.popViewControllerAnimated(true)
    }
    // MARK: Set Right Button Of Navigation Bar
    func setModifyButton() {

        let imageButton = (self.isUpdateStudent) ? UIImage(named: "Checked") : UIImage(named: "Edit")
        modifyButton = UIBarButtonItem(image: imageButton, style: .Done, target: self, action: #selector(self.modifyAction))
        self.navigationItem.rightBarButtonItem = modifyButton
    }

    @IBAction func addImageAction(sender: AnyObject) {

        let addImageAlertController = UIAlertController(title: "Choose How You Would Like To Add Image", message: "", preferredStyle: .ActionSheet)
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        let takePictureAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { (action) in self.openCamera() }
        let choosePictureAlertAction = UIAlertAction(title: "Choose Frome Camera Roll", style: .Default) { (action) in self.openCameraRool() }

        addImageAlertController.addAction(cancelAlertAction)
        addImageAlertController.addAction(takePictureAlertAction)
        addImageAlertController.addAction(choosePictureAlertAction)
        self.presentViewController(addImageAlertController, animated: true, completion: nil)
    }

    // MARK: Set Avatar UI
    func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.clipsToBounds = true
    }

    // MARK: Set Data UI
    func setDataUI() {
        self.addImageButton.hidden = true
        self.idTextField.text = self.student.id
        self.nameTextField.text = self.student.name
        self.ageTextField.text = String(self.student.age)
        self.genderSegment.selectedSegmentIndex = (self.student.gender) ? 0 : 1
        if !self.student.imageName.isEmpty {
            self.avatarImageView.image = FileManager.sharedInstance.loadFile(self.student.imageName, typeDirectory: .CachesDirectory)
        }
    }

    // MARK: Save Update Student
    func saveUpdateStudent() {

        if self.checkValid() {

            do {
                let realm = try Realm()
                try realm.write({
                    self.changeInfomationStudent()
                })

            } catch let error as NSError {
                print(error.localizedDescription)
            }

            RealmManager.sharedInstance.updateObjectWithPrimaryKeys(self.student)
            self.notificationCenter.postNotificationName(NotificationCenterKey.modifyStudent, object: nil,
                userInfo: ["indexPathStudent": self.indexPathStudent])

        } else {
            self.setDataUI()
        }

    }

    // MARK: Change Information Of Student
    func changeInfomationStudent() {
        self.student.name = self.nameTextField.text!
        if let age = Int(self.ageTextField.text!) {
            self.student.age = age
        }
        if let image = self.image {
            let imageNameToDelete = self.student.imageName
            self.student.imageName = self.saveImage(image)
            FileManager.sharedInstance.deleteFile(imageNameToDelete, typeDirectory: .CachesDirectory)
        }
        let indexSegment = self.genderSegment.selectedSegmentIndex
        if indexSegment == 0 {
            student.gender = true
        } else {
            student.gender = false
        }
    }

    // MAKR: Open Modify Action
    func modifyAction() {

        if self.isUpdateStudent {
            self.saveUpdateStudent()
            self.isUpdateStudent = false
        } else {
            self.isUpdateStudent = true
        }
        self.activeModify(!isUpdateStudent)
        self.setModifyButton()

    }

    func activeModify(isUpdate: Bool) {
        self.addImageButton.hidden = isUpdate
        self.nameTextField.enabled = !isUpdate
        self.ageTextField.enabled = !isUpdate
        self.genderSegment.enabled = !isUpdate
        self.deleteStudentButton.enabled = isUpdate
    }

    // MARK: Check Valid
    private func checkValid() -> Bool {
        guard let _ = self.nameTextField.text where self.nameTextField.text != nil && self.nameTextField.text != "" else {
            return false
        }

        guard let _ = self.ageTextField.text where self.ageTextField.text != nil && self.ageTextField.text != "" else {
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
extension DetailAndModifyStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
