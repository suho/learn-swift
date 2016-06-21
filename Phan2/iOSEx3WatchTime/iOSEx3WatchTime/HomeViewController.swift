//
//  HomeViewController.swift
//  iOSEx3WatchTime
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var timeSystem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setTime()
    }
    
    func convertDateToString(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm:ss dd-MM-yyyy"
        
        let dateString = format.stringFromDate(date)
        
        return dateString
    }
    
    func setTime() {
        self.timeSystem.text = "\(self.convertDateToString(NSDate()))"
    }
}
