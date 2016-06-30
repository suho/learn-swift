//
//  HomeViewController.swift
//  Exercise_DrawClock
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var clock: BallView!
    var secondLine: LineView!
    var minuteLine: LineView!
    var hourLine: LineView!
    var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        self.clock = BallView(frame: CGRect(x: screenWidth/2 - 100, y: screenHeight/2-200, width: 200, height: 200))
        self.secondLine = LineView(frame: clock.bounds)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.setTimeForClock), userInfo: nil, repeats: true)
        self.clock.addSubview(secondLine)
        self.minuteLine = LineView(frame: clock.bounds)
        self.minuteLine.boldNumber = 2
        self.minuteLine.pointEnd = CGPoint(x: 100 + CGFloat(70*cos(0.0)), y: 100 + CGFloat(70*sin(0.0)))
        self.clock.addSubview(minuteLine)
        self.hourLine = LineView(frame: clock.bounds)
        self.hourLine.boldNumber = 3
        self.hourLine.pointEnd = CGPoint(x: 100 + CGFloat(40*cos(M_PI/4)), y: 100 + CGFloat(40*sin(M_PI/4)))
        self.clock.addSubview(hourLine)
        self.view.addSubview(self.clock)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertDateToString(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm:ss"
        
        let dateString = format.stringFromDate(date)
        
        return dateString
    }
    
    func setTimeForClock() {
        let time = convertDateToString(NSDate())
        let splitTime = time.characters.split{$0 == ":"}.map(String.init)
        let second = Double(splitTime[2])
        let radian = (second! * 2 * M_PI)/60 - (M_PI/2)
        self.secondLine.pointEnd = CGPoint(x: 100 + CGFloat(90*cos(radian)),y: 100 + CGFloat(90*sin(radian)))
        self.view.reloadInputViews()
    }

}
