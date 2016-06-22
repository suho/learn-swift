//
//  CustomSliderView.swift
//  Exercise7_SliderBarWithProtocol
//
//  Created by Mylo Ho on 6/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

protocol CustomSliderDelegate {
    func getPercent(percent: String)
    func messageError(message: String)
}

class CustomSliderView: UIView {
    
    @IBOutlet weak var disableView: UIView!
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var ballLabel: UILabel!
    
    var delegate: CustomSliderDelegate!
    
    var location = CGPoint(x: 0, y: 0)
    var locationOld = CGPoint(x: 0, y: 0)
    
    var touchOld: UITouch! = nil
    var touch: UITouch! = nil
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touch == nil {
            touch = touches.first! as UITouch
            location = touch.locationInView(self)
            touchOld = touch
            locationOld = touchOld.locationInView(self)
            
        } else {
            touch = touches.first! as UITouch
            location = touch.locationInView(self)
            if touch != touchOld {
                touchOld = touch
                locationOld = touchOld.locationInView(self)
                self.move()
            } else {
                self.move()
            }
            
            
        }
    }
    
    internal func setPercent(percent: String) {
        
        var percentNumber = percent
        
        if percentNumber.characters.last == "%" {
            percentNumber = percentNumber.substringToIndex(percentNumber.endIndex.predecessor())
        }
        
        if let rightPercent = Float(percentNumber) {
            
            var ballViewCenter = self.ballView.center
            var availableViewFrame = self.availableView.frame
            
            if rightPercent >= 0 && rightPercent <= 100 {
                ballViewCenter.y = 200 - 2*CGFloat(rightPercent)
                availableViewFrame.size.height = 2*CGFloat(rightPercent)
                availableViewFrame.origin.y = ballViewCenter.y
                UIView.animateWithDuration(2, animations: {
                    self.availableView.frame = availableViewFrame
                    self.ballView.center = ballViewCenter
                    }, completion: { (complete) in
                        self.ballLabel.text = "\(rightPercent)%"
                })
            } else {
                if let delegate = self.delegate {
                    delegate.messageError("Value Percent More Than 0 Or Less Thanh 100!!")
                }

            }
        } else {
            if let delegate = self.delegate {
                delegate.messageError("Please Input A Number")
            }
        }
    }
    
    func move() {
        let moveY = location.y - locationOld.y
        let imageY = self.ballView.center.y
        
        let bottomFullBar = self.disableView.frame.size.height
        
        if isTouchedObject(location) {
            if !(imageY < 0 || imageY > bottomFullBar) {
                
                self.ballView.center.y = imageY + moveY
                self.availableView.frame.origin.y = imageY + moveY
                self.availableView.frame.size.height -= moveY
                let heightAvailable = self.availableView.frame.size.height
                let heightDisable = self.disableView.frame.size.height
                var percent = (heightAvailable/heightDisable)*100
                if percent > 100 {
                    self.ballView.center.y = 0
                    self.availableView.frame.size.height = self.disableView.frame.size.height
                    self.availableView.frame.origin.y = 0
                    percent = 100
                    self.ballLabel.text = "\(percent)%"
                    locationOld = location
                    
                    
                } else if location.y > self.disableView.frame.origin.y + self.disableView.frame.size.height {
                    
                    self.ballView.center.y = bottomFullBar
                    self.availableView.frame.size.height = 0
                    self.availableView.frame.origin.y = self.disableView.frame.size.height
                    percent = 0
                    self.ballLabel.text = "\(percent)%"
                    locationOld = location
                    
                } else {
                    self.ballLabel.text = "\(percent)%"
                    locationOld = location
                    
                }
                
            } else {
                if imageY > bottomFullBar {
                    self.ballView.center.y = bottomFullBar
                    self.availableView.frame.size.height = 0
                    self.availableView.frame.origin.y = self.disableView.frame.size.height
                    locationOld = location
                    
                }
            }
        } else {
            
        }
        
        if let delegate = self.delegate {
            delegate.getPercent(self.ballLabel.text!)
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
        let leftBall = frameImage.origin.x + self.ballView.frame.origin.x
        let widthBall = self.ballView.frame.size.width
        let topBall = frameImage.origin.y + self.ballView.frame.origin.y
        let heightBall = self.ballView.frame.size.height
        
        
        if (touch.x >= leftBall) && (touch.x <= widthBall + leftBall) && (touch.y >= topBall) && (touch.y <= heightBall + topBall) {
            return true
        } else {
            return false
        }
    }
    

}
