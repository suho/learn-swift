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
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
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
}
