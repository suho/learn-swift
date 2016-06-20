//
//  HomeViewController.swift
//  iOSEx5CustomSlider
//
//  Created by Mylo Ho on 6/17/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak private var disableView: UIView!
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var ball: UIView!
    @IBOutlet weak var imageBall: UIImageView!
    @IBOutlet weak var lblPercent: UILabel!
    
    
    var location = CGPoint(x: 0, y: 0)
    var locationOld = CGPoint(x: 0, y: 0)
    
    var touchOld: UITouch! = nil
    var touch: UITouch! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageBall.image = UIImage(named: "ball")
        self.ball.backgroundColor = UIColor(patternImage: UIImage(named: "ball.png")!)
        self.lblPercent.text = "50.0%"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touch == nil {
            touch = touches.first! as UITouch
            location = touch.locationInView(self.view)
            
            touchOld = touch
            locationOld = touchOld.locationInView(self.view)
            
        } else {
            touch = touches.first! as UITouch
            location = touch.locationInView(self.view)
            
            if touch != touchOld {
                touchOld = touch
                locationOld = touchOld.locationInView(self.view)
                self.move()
            } else {
                self.move()
            }
            
            
        }
    }
    
    func move() {
        let moveY = location.y - locationOld.y
        let imageY = self.ball.center.y
        
        let bottomFullBar = self.disableView.frame.size.height
        
        if isTouchedObject(location) {
            if !(imageY < 0 || imageY > bottomFullBar) {
                
                self.ball.center.y = imageY + moveY
                self.availableView.frame.origin.y = imageY + moveY
                self.availableView.frame.size.height -= moveY
                let heightAvailable = self.availableView.frame.size.height
                let heightDisable = self.disableView.frame.size.height
                var percent = (heightAvailable/heightDisable)*100
                if percent > 100 {
                    self.ball.center.y = 0
                    self.availableView.frame.size.height = self.disableView.frame.size.height
                    self.availableView.frame.origin.y = 0
                    percent = 100
                    self.lblPercent.text = "\(percent)%"
                    locationOld = location
                    return
                    
                } else if location.y > self.disableView.frame.origin.y + self.disableView.frame.size.height {
                    
                    self.ball.center.y = bottomFullBar
                    self.availableView.frame.size.height = 0
                    self.availableView.frame.origin.y = self.disableView.frame.size.height
                    percent = 0
                    self.lblPercent.text = "\(percent)%"
                    locationOld = location
                    return
                } else {
                    self.lblPercent.text = "\(percent)%"
                    locationOld = location
                    return
                }

            } else {
                if imageY > bottomFullBar {
                    
                    self.ball.center.y = bottomFullBar
                    self.availableView.frame.size.height = 0
                    self.availableView.frame.origin.y = self.disableView.frame.size.height
                    locationOld = location
                    return
                }
            }
        } else {
            return
        }
        
    }
    
    func isTouchedDisableView(touch: CGPoint) -> Bool {
        
        let frameView = self.disableView.frame
        let leftView = frameView.origin.x
        let widthView = self.disableView.frame.size.width
        let topView = frameView.origin.y
        let heightView = self.disableView.frame.size.height
        
        
        if (touch.x >= leftView) && (touch.x <= widthView + leftView) && (touch.y >= topView) && (touch.y <= heightView + topView) {
            return true
        } else {
            return false
        }

    }
    
    
    func isTouchedObject(touch: CGPoint) -> Bool {
        let frameImage = self.disableView.frame
        let leftBall = frameImage.origin.x + self.ball.frame.origin.x
        let widthBall = self.ball.frame.size.width
        let topBall = frameImage.origin.y + self.ball.frame.origin.y
        let heightBall = self.ball.frame.size.height
        
        
        if (touch.x >= leftBall) && (touch.x <= widthBall + leftBall) && (touch.y >= topBall) && (touch.y <= heightBall + topBall) {
            return true
        } else {
            return false
        }
    }

}
