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
    var calculation: String?
    
    @IBAction func btnAc(sender: AnyObject) {
        self.txtFieldResult.text = "0"
        self.isTypingNumber = false
        self.resultNumber = 0
        self.calculation = ""

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
        
        let calculation: String = (sender.currentTitle?!)!

        
        switch calculation {
        case "+":
            if isTypingNumber {
                if self.calculation == "-" {
                    self.resultNumber -= Int(self.txtFieldResult.text!)!
                    self.isTypingNumber = false
                } else {
                    self.resultNumber += Int(self.txtFieldResult.text!)!
                    self.isTypingNumber = false
                }
                self.calculation = "+"
            } else {
                self.calculation = "+"
                return
            }
            
        default:
            if isTypingNumber {
                if self.calculation == "+" {
                    self.resultNumber += Int(self.txtFieldResult.text!)!
                    self.isTypingNumber = false
                    self.calculation = "-"
                } else {
                    if self.resultNumber == 0 {
                        self.resultNumber = Int(self.txtFieldResult.text!)!
                        self.isTypingNumber = false
                        self.calculation = "-"
                    } else {
                        self.resultNumber -= Int(self.txtFieldResult.text!)!
                        self.isTypingNumber = false
                        self.calculation = "-"
                    }
                }
            } else {
                self.calculation = "-"
                return
            }
            
        }
        self.txtFieldResult.text = "\(resultNumber)"
    }
    
    @IBAction func btnEquals(sender: AnyObject) {
        self.isTypingNumber = false
        switch self.calculation {
        case "+"?:
            self.resultNumber += Int(self.txtFieldResult.text!)!
        case "-"?:
            self.resultNumber -= Int(self.txtFieldResult.text!)!
        default:
            self.resultNumber += Int(self.txtFieldResult.text!)!
        }
        self.txtFieldResult.text = "\(resultNumber)"
        self.isTypingNumber = false
        self.calculation = ""
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

