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
    var lastNumber: Int? = nil
    
    @IBAction func btnAc(sender: AnyObject) {
        self.txtFieldResult.text = "0"
        self.isTypingNumber = false
        self.resultNumber = 0
        self.calculation = ""
        self.lastNumber = nil

    }
    @IBAction func btnNumber(sender: AnyObject) {
        let number = sender.currentTitle
        if self.isTypingNumber {
            if self.txtFieldResult.text?.characters.count > 6 {
                return
            } else {
                self.txtFieldResult.text = self.txtFieldResult.text! + number!!
                self.lastNumber = Int(self.txtFieldResult.text!)!
            }
        } else {
            //self.txtFieldResult.text = "0"
            if number == "0" {
                return
            } else {
                self.txtFieldResult.text = number
                self.lastNumber = Int(self.txtFieldResult.text!)!
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
                self.lastNumber = Int(self.txtFieldResult.text!)!
                return
            }
            
        }
        self.txtFieldResult.text = "\(resultNumber)"
    }
    
    @IBAction func btnEquals(sender: AnyObject) {
        if (calculation == "+" || calculation == "-") && !isTypingNumber {
             self.lastNumber = self.resultNumber
            switch self.calculation {
            case "+"?:
                calculation = "+="
            default:
                calculation = "-="
            }
        }
        if calculation != "" {
            switch self.calculation {
            case "+"?:
                self.resultNumber += Int(self.txtFieldResult.text!)!
                self.calculation = "+="
            case "-"?:
                self.resultNumber -= Int(self.txtFieldResult.text!)!
                self.calculation = "-="
            case "+="?:
                self.resultNumber += self.lastNumber!
                self.calculation = "+="
            case "-="?:
                self.resultNumber -= self.lastNumber!
                self.calculation = "-="
            default:
                self.resultNumber += Int(self.txtFieldResult.text!)!
            }
        }
        self.txtFieldResult.text = "\(resultNumber)"
        self.isTypingNumber = false
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

