//
//  BallView.swift
//  Exercise2_Draw_Ball
//
//  Created by Mylo Ho on 6/24/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

@IBDesignable

class BallView: UIView {
    
    @IBInspectable var ballColor: UIColor = UIColor.brownColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var velocityX: CGFloat = 0.5
    var velocityY: CGFloat = 0.6
    var speed: NSTimeInterval = 0.004

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        _ = NSTimer.scheduledTimerWithTimeInterval(self.speed, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        //Solution 1: Use Object Path To Draw Oval
        
        let path = UIBezierPath(ovalInRect: rect)
        ballColor.setFill()
        path.fill()
        
        //Solution 2: Draw By Context Of Quartz 2D
        
        /*let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, self.ballColor.CGColor)
        CGContextFillEllipseInRect(context, self.bounds)*/
        
        
    }
    
    func update() {
        self.frame.origin.y += self.velocityY
        self.frame.origin.x += self.velocityX
        if ((self.frame.origin.y + self.frame.size.height) > self.screenHeight) || (self.frame.origin.y < 0)  {
            self.velocityY = (-1)*self.velocityY
        }
        if (self.frame.origin.x < 0) || ((self.frame.origin.x + self.frame.size.width) > self.screenWidth) {
            self.velocityX = (-1)*self.velocityX
        }
    }

}
