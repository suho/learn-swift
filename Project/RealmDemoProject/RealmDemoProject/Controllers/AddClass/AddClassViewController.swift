//
//  AddClassViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class AddClassViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameFacultyTextField: UITextField!
    @IBOutlet weak var nameClassTextField: UITextField!

    let imagePicker = UIImagePickerController()

    var image: UIImage! = nil

    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Class"
        self.imagePicker.delegate = self
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setAvatarUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addAction(sender: AnyObject) {

        if self.checkValid() {
            let classObject = Class()

            var countId = 0

            do {

                let realm = try Realm()
                let classes = realm.objects(Class)
                countId = classes.count + 1

            } catch {
                print("Realm Have Error!!!")
            }

            classObject.idClass = getfileName(countId)
            classObject.facultyName = self.nameFacultyTextField.text!
            classObject.nameClass = self.nameClassTextField.text!
            if let image = self.image {
                classObject.imageName = self.saveImage(image)
            }

            RealmManager.sharedInstance.addObject(classObject)
            self.navigationController?.popViewControllerAnimated(true)
            self.notificationCenter.postNotificationName(NotificationCenterKey.addNewClass, object: nil)
        }
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

    // MARK: Set UI For Avatar
    private func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.layer.masksToBounds = true
    }

    // MARK: Check Valid
    private func checkValid() -> Bool {
        guard let _ = self.nameFacultyTextField.text where self.nameFacultyTextField.text != nil && self.nameFacultyTextField.text != "" else {
            return false
        }

        guard let _ = self.nameClassTextField.text where self.nameClassTextField.text != nil && self.nameClassTextField.text != "" else {
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

    // MARK: Get File Name
    func getfileName(id: Int) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd_MM_yyyy_hh_mm_ss"
        return "\(dateFormatter.stringFromDate(NSDate()))\(id)"
    }

}

//MARK: Image Picker Delegate
extension AddClassViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
