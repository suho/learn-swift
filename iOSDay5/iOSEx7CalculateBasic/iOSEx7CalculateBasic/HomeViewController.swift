//
//  HomeViewController.swift
//  iOSEx7CalculateBasic
//
//  Created by Mylo Ho on 6/17/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var txtFieldResult: UITextField!
    
    var isTypingNumber = false
    var resultNumber = 0
    
    @IBAction func btnAc(sender: AnyObject) {
        self.txtFieldResult.text = "0"
        self.isTypingNumber = false
        self.resultNumber = 0

    }
    @IBAction func btnNumber(sender: AnyObject) {
        let number = sender.currentTitle
        if self.isTypingNumber {
            if self.txtFieldResult.text?.characters.count > 6 {
                return
            } else {
                self.txtFieldResult.text = self.txtFieldResult.text! + number!!
            }
        } else {
            self.txtFieldResult.text = "0"
            if number == "0" {
                return
            } else {
                self.txtFieldResult.text = number
                self.isTypingNumber = true
            }
        }
    }
    
    @IBAction func btnCalculation(sender: AnyObject) {
        self.isTypingNumber = false
        if sender.currentTitle == "+" {
            self.resultNumber += Int(self.txtFieldResult.text!)!
        } else if sender.currentTitle == "-" {
            self.resultNumber -= Int(self.txtFieldResult.text!)!
        }
        
        self.txtFieldResult.text = "\(resultNumber)"
    }
    
    @IBAction func btnEquals(sender: AnyObject) {
        self.isTypingNumber = false
        self.resultNumber += Int(self.txtFieldResult.text!)!
        self.txtFieldResult.text = "\(resultNumber)"
        self.resultNumber = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldResult.text = "0"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
