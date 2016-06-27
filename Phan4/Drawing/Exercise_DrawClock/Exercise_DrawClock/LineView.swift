//
//  LineView.swift
//  Exercise_DrawClock
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var boldNumber: CGFloat!
    var lineColor: UIColor!
    var pointBeign: CGPoint!
    var pointEnd: CGPoint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        boldNumber = 1
        lineColor = UIColor.blackColor()
        pointBeign = CGPoint(x: frame.width/2, y: frame.height/2)
        pointEnd = CGPoint(x: 100 + CGFloat(90*cos(3*M_PI/2)), y: 100 + CGFloat(90*sin(3*M_PI/2)))
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, self.boldNumber) //Độ đậm
        
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor)
        
        CGContextMoveToPoint(context, self.pointBeign.x, self.pointBeign.y) //điểm đầu
        
        
        CGContextAddLineToPoint(context, self.pointEnd.x, self.pointEnd.y) //điểm cuối
        
        CGContextStrokePath(context)
    }

}
