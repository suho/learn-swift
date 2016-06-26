//
//  CustomSegmentView.swift
//  Exercise_CustomSegment_24_06
//
//  Created by Mylo Ho on 6/26/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

protocol CustomSegmentDelegate {
    func setLabelText(text: String)
}

class CustomSegmentView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var yearlyView: UIView!
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    
    var delegate: CustomSegmentDelegate!
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let contentViewFrame = self.contentView.frame
        let contentViewX = contentViewFrame.origin.x
        let contentViewWidth = contentViewFrame.size.width
        let touch = touches.first! as UITouch
        var isMoveToLeft = true
        
        if touch.view == self.weeklyView {
            var frame = self.availableView.frame
            
            frame.origin.x = contentViewX
            
            UIView.animateWithDuration(0.3, animations: {
                self.availableView.frame = frame
                }, completion: { (complete) in
                    isMoveToLeft = true
                    self.availableView.shake(isMoveToLeft)
            })
            if let delegate = self.delegate {
                delegate.setLabelText(labelWeek.text!)
            }
        }
        
        if touch.view == self.monthlyView {
            var frame = self.availableView.frame
            if frame.origin.x == contentViewX {
                isMoveToLeft = false
            } else {
                isMoveToLeft = true
            }
            frame.origin.x = contentViewWidth/3 + contentViewX
            
            UIView.animateWithDuration(0.3, animations: {
                self.availableView.frame = frame
                }, completion: { (complete) in
                    self.availableView.shake(isMoveToLeft)
            })
            if let delegate = self.delegate {
                delegate.setLabelText(labelMonth.text!)
            }
        }
        
        if touch.view == self.yearlyView {
            
            var frame = self.availableView.frame
            
            frame.origin.x = 2*contentViewWidth/3 + contentViewX
            
            UIView.animateWithDuration(0.3, animations: {
                self.availableView.frame = frame
                }, completion: { (complete) in
                    isMoveToLeft = false
                    self.availableView.shake(isMoveToLeft)
            })
            if let delegate = self.delegate {
                delegate.setLabelText(labelYear.text!)
            }
        }
        
    }
    
}

extension UIView {
    func shake(isMoveToLeft: Bool) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        if isMoveToLeft {
            animation.values = [-5.0, 5.0, 0.0]
        } else {
            animation.values = [5.0, -5.0, 0.0]
        }
        layer.addAnimation(animation, forKey: "shake")
    }
}
