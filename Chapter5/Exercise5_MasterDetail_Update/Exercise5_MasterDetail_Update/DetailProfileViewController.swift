//
//  DetailProfileViewController.swift
//  Exercise5_MasterDetail_Update
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

protocol DetailProfileDelegate {
    func dataStudentChange(indexRow: Int, student: Student)
}

class DetailProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    
    var delegate: DetailProfileDelegate!
    
    let imagePicker = UIImagePickerController()

    var indexRow: Int = 0
    
    var student = Student(name: "John Smith.", age: 31, gender: true, avatar: "3", avatarPath: "")
    
    var studentChange = Student(name: "", age: 0, gender: true, avatar: "", avatarPath: "")
    
    var isChangeImage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PROFILE"
        
        self.age.delegate = self
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.updateInformation))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.imagePicker.delegate = self
        
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.grayColor().CGColor
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        if student.avatar == "" {
            self.avatar.image = UIImage(contentsOfFile: student.avatarPath)
        } else {
            self.avatar.image = UIImage(named: student.avatar)
        }
        self.name.text = student.name
        self.age.text = "\(student.age)"
        self.gender.selectedSegmentIndex = (student.gender) ? 0 : 1
        
        self.studentChange = self.student
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapImage))
        self.avatar.userInteractionEnabled = true
        self.avatar.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        if touch.view == self.view {
            self.name.resignFirstResponder()
            self.age.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInformation() {
        
        if isChangeImage {
            let path = pathOfFile(convertDateToNameImage())
            saveImage(self.avatar.image!, path: path)
            self.studentChange.avatar = ""
            self.studentChange.avatarPath = path
        }
        self.studentChange.name = self.name.text!
        
        if let ageChange = Int(self.age.text!) {
            self.studentChange.age = ageChange
        } else {
            let alert = UIAlertController(title: "Error", message: "Wrong Age", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        self.studentChange.gender = (self.gender.selectedSegmentIndex == 0) ? true : false
        
        if let delegate = self.delegate {
            delegate.dataStudentChange(self.indexRow, student: self.studentChange)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func convertDateToNameImage() -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        
        let dateString = format.stringFromDate(NSDate())
        
        return dateString
    }
    
}

extension DetailProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = UIDatePickerMode.Date
//        textField.inputView = datePicker
//        
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd MM yyyy"
//        let selectedDate = dateFormatter.stringFromDate(datePicker.date)
//        print(selectedDate)
        
    }
}

extension DetailProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func tapImage(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            avatar.contentMode = .ScaleToFill
            avatar.image = pickedImage
            self.isChangeImage = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func documentDirectory() -> NSString {
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
    }
    
    func pathOfFile(fileName: String) -> String {
        return documentDirectory().stringByAppendingPathComponent(fileName)
    }
    
    func saveImage(image: UIImage, path: String) {
        let pngImageData = UIImagePNGRepresentation(image)
        _ = pngImageData?.writeToFile(path, atomically: true)
    }
}
