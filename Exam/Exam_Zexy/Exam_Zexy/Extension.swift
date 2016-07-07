//
//  Extension.swift
//  Exam_Zexy
//
//  Created by Mylo Ho on 7/7/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func xYShake(moveX: CGFloat, moveY: CGFloat) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.autoreverses = true
        
        let from_value:NSValue = NSValue(CGPoint: CGPointMake(center.x - moveX, center.y - moveY))
        let to_value:NSValue = NSValue(CGPoint: CGPointMake(center.x + moveX, center.y + moveY))
        
        animation.fromValue = from_value
        animation.toValue = to_value
        layer.addAnimation(animation, forKey: "position")
        
    }
    
    func setAnimationWithAlpha(alpha: CGFloat) {
        UIView.animateWithDuration(0.3, animations: {
            self.alpha = alpha
            }, completion: { (complete) in
                
        })
    }
}