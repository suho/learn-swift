//
//  HomeViewController.swift
//  iOSEx1HelloName
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var labelHello: UILabel!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldName.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnHelloName(sender: AnyObject) {
        printHelloName()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textFieldName.resignFirstResponder()
        self.actionWhenHideKeyBoard()
    }
    
    func printHelloName() -> Void {
        let name = self.textFieldName.text!.trim()
        
        if name == "" {
            self.labelHello.text = "Please Input Name!!"
            self.labelHello.textColor = UIColor.redColor()
        } else {
            self.labelHello.text = "Hello \(name)!!"
            self.labelHello.textColor = UIColor.greenColor()
        }
        self.textFieldName.resignFirstResponder()
        self.actionWhenHideKeyBoard()
    }
    
    func actionWhenShowKeyBoard() -> Void {
        var frame = self.view.frame
        if frame.origin.y < 0 {
            return
        } else {
            frame.origin.y = -150
            UIView.animateWithDuration(0.3, animations: {
                self.view.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
    
    func actionWhenHideKeyBoard() -> Void {
        var frame = self.view.frame
        if frame.origin.y == 0 {
            return
        } else {
            frame.origin.y = 0
            UIView.animateWithDuration(0.5, animations: {
                self.view.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
    
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.actionWhenShowKeyBoard()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.textFieldName == textField {
            printHelloName()
        }
        return true
    }
}









