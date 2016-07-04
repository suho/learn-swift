//
//  HomeViewController.swift
//  Excercise9_CardBook
//
//  Created by Mylo Ho on 7/1/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var chooseMenu: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchAction(sender: AnyObject) {
    }
    @IBOutlet weak var detailButton: UIButton!
    @IBAction func detailAction(sender: AnyObject) {
    }
   
    @IBOutlet weak var timeButton: UIButton!
    @IBAction func timeAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        let backgroundColor = UIColor(red: 68.0/255, green: 68.0/255, blue: 68.0/255, alpha: 1.0)
        
        self.view.backgroundColor = backgroundColor
        self.homeTableView.backgroundColor = backgroundColor
        
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
        self.homeTableView.registerNib(UINib(nibName: "CardBookTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.blurView.hidden = true
        self.chooseMenu.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        if !self.blurView.hidden && (touch.view == self.blurView || touch.view == self.chooseMenu) {
            self.cancelMenuAction(self)
        }
        
    }
    
    @IBAction func settingAction(sender: AnyObject) {
        print("Tapped Setting Action")
        
    }
    
    @IBAction func menuTappedAction(sender: AnyObject) {
        self.blurView.hidden = false
        self.menuView.hidden = true
        self.chooseMenu.hidden = false
        
        self.animationOfSearchButton(true)
        self.animationOfDetailButton(true)
        self.animationOfTimeButton(true)
    }
    
    @IBAction func cancelMenuAction(sender: AnyObject) {
        
        self.animationOfSearchButton(false)
        self.animationOfDetailButton(false)
        self.animationOfTimeButton(false)
        
        self.runAfterDelay(0.25) {
            self.blurView.hidden = true
            self.chooseMenu.hidden = true
            self.menuView.hidden = false
        }
    }
    
    func animationOfSearchButton(willStart: Bool)  {
        
        let beginFrame = self.searchButton.frame
        
        if willStart {
            
            let finishFrame = self.searchButton.frame
            self.searchButton.center = self.closeButton.center
            
            UIView.animateWithDuration(0.3, animations: {
                self.searchButton.frame = finishFrame
                }, completion: { (complete) in
                    self.searchButton.yShake()
            })
        } else {
            
            let finishPosition = self.closeButton.center
            
            UIView.animateWithDuration(0.3, animations: {
                self.searchButton.center = finishPosition
                }, completion: { (complete) in
                self.searchButton.frame = beginFrame
            })
        }
        
        
        
    }
    
    func animationOfDetailButton(willStart: Bool)  {
        
        let beginFrame = self.detailButton.frame
        
        if willStart {
            
            let finishFrame = self.detailButton.frame
            self.detailButton.center = self.closeButton.center
            
            UIView.animateWithDuration(0.3, animations: {
                self.detailButton.frame = finishFrame
                }, completion: { (complete) in
                    self.detailButton.xShake()
            })
        } else {
            
            let finishPosition = self.closeButton.center
            UIView.animateWithDuration(0.3, animations: {
                self.detailButton.center = finishPosition
                }, completion: { (complete) in
                    self.detailButton.frame = beginFrame
            })
        }
        
    }
    
    func animationOfTimeButton(willStart: Bool)  {
        
        let beginFrame = self.timeButton.frame
        
        if willStart {
            
            let finishFrame = self.timeButton.frame
            self.timeButton.center = self.closeButton.center
            
            UIView.animateWithDuration(0.3, animations: {
                self.timeButton.frame = finishFrame
                }, completion: { (complete) in
                    self.timeButton.xYShake()
            })
        } else {
            
            let finishPosition = self.closeButton.center
            UIView.animateWithDuration(0.3, animations: {
                self.timeButton.center = finishPosition
                }, completion: { (complete) in
                    self.timeButton.frame = beginFrame
            })
        }
        
    }
    
    func runAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), block)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Int(arc4random_uniform(10) + 5)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.height/300
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clearColor()
        return header
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.size.height/4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CardBookTableViewCell
        return cell
    }
    
}

extension UIButton {
    
    func xShake(){
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.8
        animation.values = [ -5.0, 5.0, -5.0, 5.0, 0.0 ]
        animation.additive = true
        layer.addAnimation(animation, forKey: "shake")
    }
    
    func yShake(){
        let animation = CAKeyframeAnimation(keyPath: "position.y")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.8
        animation.values = [ -5.0, 5.0, -5.0, 5.0, 0.0  ]
        animation.additive = true
        layer.addAnimation(animation, forKey: "shake")
    }
    
    func xYShake() {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.2
        animation.repeatCount = 2
        animation.autoreverses = true
        
        let from_value:NSValue = NSValue(CGPoint: CGPointMake(center.x - 3, center.y - 3))
        let to_value:NSValue = NSValue(CGPoint: CGPointMake(center.x + 3, center.y + 3))
        
        animation.fromValue = from_value
        animation.toValue = to_value
        layer.addAnimation(animation, forKey: "position")
        
        let fromPoint = CGPointMake(center.x - 3, center.y - 3)
        center = fromPoint
    }
}