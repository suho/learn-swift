//
//  HomeViewController.swift
//  iOSEx4Timer
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var timeSystem: UILabel!
    
    var timer = NSTimer()
    var isRun = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.setTime), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isRun {
            timer.invalidate()
            isRun = false
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.setTime), userInfo: nil, repeats: true)
            isRun = true
        }
    }
    
    func convertDateToString(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm:ss"
        
        let dateString = format.stringFromDate(date)
        
        return dateString
    }
    
    func setTime() {
        self.timeSystem.text = "\(self.convertDateToString(NSDate()))"
    }


}
