//
//  LineView.swift
//  Exercise1_DrawGraphs
//
//  Created by Mylo Ho on 6/24/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    
    var boldNumber: CGFloat = 1
    var lineColor = UIColor.blackColor()
    var pointBeign = CGPoint(x: (UIScreen.mainScreen().bounds.width/3)/2, y: (UIScreen.mainScreen().bounds.height/3)/2)
    var pointEnd = CGPoint(x: (UIScreen.mainScreen().bounds.width/3)/2, y: 0)
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
