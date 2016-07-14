//
//  NewHomeViewController.swift
//  Exam_CountTimeAgo
//
//  Created by Mylo Ho on 7/14/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class NewHomeViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var time: UILabel!
    var pastDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        datePicker.maximumDate = NSDate()
        datePicker.datePickerMode = .DateAndTime
        datePicker.addTarget(self, action: #selector(self.getDate), forControlEvents: .ValueChanged)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.getNewTime), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(sender: AnyObject) {
    }
    
    func getNewTime() {
        self.datePicker.maximumDate = NSDate()
    }
    
    func getDate(sender: UIDatePicker) {
        self.pastDate = sender.date
    }

}
