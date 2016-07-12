//
//  RegisterViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    let imagePicker = UIImagePickerController()
    
    let user = User()
    
    var isChangeAvatar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.navigationController?.navigationBarHidden = false
        self.fullNameTextField.delegate = self
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.ageTextField.delegate = self
        
        self.imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapImage))
        self.avatarImageView.userInteractionEnabled = true
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height/2
        self.avatarImageView.clipsToBounds = true
    }

    @IBAction func registerAction(sender: AnyObject) {
        
        let textFields: [UITextField] = [self.fullNameTextField, self.usernameTextField, self.passwordTextField, self.confirmPasswordTextField, self.emailTextField]
        
        if self.checkEmpty(textFields) {
            return
        }
        
        if let email = self.emailTextField.text {
            if !email.checkValidEmail() {
                self.showMessage("Email Not Valid")
                self.emailTextField.text = ""
                return
            }
        }
        
        if self.phoneTextField.text != "" {
            let phone = self.phoneTextField.text!
            if !phone.checkValidNumber(8, maxLenght: 15) {
                self.showMessage("Phone Not Valid")
                self.phoneTextField.text = ""
                return
            }
        }
        
        if self.ageTextField.text != "" {
            let age = self.ageTextField.text!
            if !age.checkValidNumber(1, maxLenght: 2) {
                self.showMessage("Age Not Valid")
                self.ageTextField.text = ""
                return
            }
        }
        
        self.getUser()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func hideKeyBoardAction(sender: AnyObject) {
        self.view.endEditing(true)
        self.view.actionWhenHideKeyBoard()
    }
    
    func checkEmpty(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if textField.text!.isEmpty {
                self.showMessage("Input Not Valid")
                return true
            }
        }
        return false
    }
    
    func getUser() {
        
        self.user.idUser = self.getNumberOfUser() + 1
        self.user.fullName = self.fullNameTextField.text!
        self.user.username = self.usernameTextField.text!
        self.user.password = self.passwordTextField.text!
        self.user.email = self.emailTextField.text!
        self.user.phone = self.phoneTextField.text!
        self.user.gender = (self.genderSegment.selectedSegmentIndex == 0) ? true : false
        
        if let age = Int(self.ageTextField.text!) {
            self.user.age = age
        } else {
            self.user.age = 0
        }
        
        if isChangeAvatar {
            let path = pathOfFile(self.convertDateToNameImage())
            //saveImage(self.avatar.image!, path: path)
            self.user.avatar = path
        } else {
           self.user.avatar = "default-avatar"
        }
        
    }
    
    func getNumberOfUser() -> Int {
        let path = NSBundle.mainBundle().pathForResource("users", ofType: ".plist")
        let data = NSArray(contentsOfFile: path!)
        return (data?.count)!
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.view.actionWhenShowKeyBoard()
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField {
            
        case self.fullNameTextField:
            self.usernameTextField.becomeFirstResponder()
            
        case self.usernameTextField:
            self.passwordTextField.becomeFirstResponder()
            
        case self.passwordTextField:
            self.confirmPasswordTextField.becomeFirstResponder()
            
        case self.confirmPasswordTextField:
            self.emailTextField.becomeFirstResponder()
            
        case self.emailTextField:
            self.phoneTextField.becomeFirstResponder()
            
        case self.phoneTextField:
            self.ageTextField.becomeFirstResponder()
            
        default:
            self.view.endEditing(true)
            self.view.actionWhenHideKeyBoard()
        }
        
        return true
    }
    
    func tapImage() {
        
        let actionSheetController: UIAlertController = UIAlertController()
        actionSheetController.view.tintColor = UIColor.orangeColor()
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in }
        
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            self.openCamera()
        }
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            self.openPhotoLibrary(self)
        }
        
        
        
        actionSheetController.addAction(takePictureAction)
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(choosePictureAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)

    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openPhotoLibrary(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(self.imagePicker, animated: true, completion: nil)
        } else {
            print("No camera")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.avatarImageView.contentMode = .ScaleToFill
            self.avatarImageView.image = pickedImage
            self.isChangeAvatar = true
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
