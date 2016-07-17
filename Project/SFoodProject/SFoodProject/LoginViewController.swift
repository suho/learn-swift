//
//  LoginViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var messageFrame = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewWillAppear(animated: Bool) {
        self.usernameTextField.text = "admin"
        self.passwordTextField.text = "admin"
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        
        if self.checkAccount(username, password: password) {
            //print("Dang nhap thanh cong")
            progressBarDisplayer("Logining...", true)
            runAfterDelay(2) {
                AppDelegate.sharedInstance.idUser = self.getIdUser(username, password: password)
                AppDelegate.sharedInstance.changeRootViewWhenLoginSuccess()
                self.messageFrame.removeFromSuperview()
            }
            
            
        } else {
            if self.checkValid(username, password: password) {
                self.showMessage("Input Not Valid")
            } else {
                self.showMessage("User Not Available")
            }
        }
    }
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        //print("Quen Mat Khau")
        let forgotPassword = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPassword, animated: true)
        
    }
    @IBAction func registerAction(sender: AnyObject) {
        //print("Dang Ky")
        let register = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(register, animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func checkAccount(username: String, password: String) -> Bool {
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist")
        let users = NSArray(contentsOfFile: path!)
        
        for user in users! {
            let _username = user.objectForKey("username") as! String
            let _password = user.objectForKey("password") as! String
            if username == _username && password == _password {
                return true
            }
        }
        
        return false
    }
    
    func getIdUser(username: String, password: String) -> Int {
        
        let path = NSBundle.mainBundle().pathForResource("users", ofType: "plist")
        let users = NSArray(contentsOfFile: path!)
        
        for user in users! {
            let _id = user.objectForKey("id") as! Int
            let _username = user.objectForKey("username") as! String
            let _password = user.objectForKey("password") as! String
            if username == _username && password == _password {
                return _id
            }
        }
        return 0

    }
    
    func checkValid(username: String, password: String) -> Bool {
        if username == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func runAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), block)
    }
    
    
    
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        
        var activityIndicator = UIActivityIndicatorView()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25 , width: 50, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        view.addSubview(messageFrame)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.loginAction(self)
        }
        return true
    }
}
