//
//  AddStudentViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class AddStudentViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameStudentTextField: UITextField!
    @IBOutlet weak var ageStudentTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var idStudentTextField: UITextField!

    let imagePicker = UIImagePickerController()

    var image: UIImage! = nil

    var classOfStudents = Class()

    let notificationCenter = NSNotificationCenter.defaultCenter()

    var indexPathClass = NSIndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Student"
        self.imagePicker.delegate = self
        self.setUpNotificationCenter()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setAvatarUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Set Up Notification
    func setUpNotificationCenter() {
    }

    @IBAction func addStudentAction(sender: AnyObject) {

        if self.checkValid() {

            let student = getNewStudent()

            do {
                let realm = try Realm()
                try realm.write({
                    self.classOfStudents.students.append(student)
                })

            } catch let error as NSError {
                print(error.localizedDescription)
            }

            RealmManager.sharedInstance.updateObjectWithPrimaryKeys(classOfStudents)
            self.navigationController?.popViewControllerAnimated(true)
            self.notificationCenter.postNotificationName(NotificationCenterKey.addNewStudent, object: nil,
                userInfo: ["indexPathClass": self.indexPathClass])
        }
    }

    // MARK: Get New Student
    func getNewStudent() -> Student {
        let student = Student()

        student.id = self.idStudentTextField.text!

        student.name = self.nameStudentTextField.text!

        if let age = Int(self.ageStudentTextField.text!) {
            student.age = age
        }

        if let image = self.image {
            student.imageName = self.saveImage(image)
        }

        let indexSegment = self.genderSegment.selectedSegmentIndex
        if indexSegment == 0 {
            student.gender = true
        } else {
            student.gender = false
        }

        student.idClass = self.classOfStudents.idClass

        return student
    }

    private func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.layer.masksToBounds = true
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

    // MARK: Check Valid
    private func checkValid() -> Bool {
        guard let _ = self.nameStudentTextField.text where self.nameStudentTextField.text != nil && self.nameStudentTextField.text != "" else {
            return false
        }

        guard let _ = self.ageStudentTextField.text where self.ageStudentTextField.text != nil && self.ageStudentTextField.text != "" else {
            return false
        }

        guard let _ = self.idStudentTextField.text where self.idStudentTextField.text != nil && self.idStudentTextField.text != "" else {
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
extension AddStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
