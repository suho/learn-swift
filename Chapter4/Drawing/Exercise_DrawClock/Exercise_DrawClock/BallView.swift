//
//  BallView.swift
//  Exercise_DrawClock
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class BallView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // Do any additional setup after loading the view.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.width/2,y: rect.height/2), radius: CGFloat(rect.width/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
        
    }

}
