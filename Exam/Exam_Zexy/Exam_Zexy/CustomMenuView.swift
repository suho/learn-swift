//
//  CustomMenuView.swift
//  Exam_Zexy
//
//  Created by Mylo Ho on 7/7/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit


protocol CustomMenuViewDelegate {
    func closeButtonAction()
}

class CustomMenuView: UIView {

    var closeButton = UIButton()
    var menuButtons: [UIButton] =  [UIButton]() {
        didSet {
            self.configView(frame)
        }
    }
    var textLabels = ["Yellow", "Green", "Blue", "Pink", "Red"]
    var delegate: CustomMenuViewDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.tag = -2
        //self.configView(frame)
        self.closeButton.addTarget(self, action: #selector(closeViewAction), forControlEvents: .TouchUpInside)
        
    }
    
    func configView(frame: CGRect) {
        
        //Add Close Button
        self.closeButton.frame = CGRect(x: frame.size.width/2 - frame.size.width/12, y: frame.size.height/2 - frame.size.width/12, width: frame.size.width/6, height: frame.size.width/6)
        self.closeButton.setImage(UIImage(named: "circle_close"), forState: .Normal)
        self.closeButton.tag = -1
        self.addSubview(closeButton)
        
        
        //Add Menu Buttons To View
        
        let numberOfMenuButtons = self.menuButtons.count
        
        let centerOfCloseButton = self.closeButton.center
        
        let frameOfCloseButton = self.closeButton.frame
        
        for i in 0..<self.menuButtons.count {
            
            let menuButton = self.menuButtons[i]
            menuButton.tag = i + 1
            menuButton.frame.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
            
            let label = UILabel()
            label.text = self.textLabels[i]
            label.tag = self.menuButtons.count + i + 1
            label.frame.size = CGSize(width: menuButton.frame.size.width, height: menuButton.frame.size.height/4)
            label.textColor = UIColor.whiteColor()
            label.textAlignment = .Center

            let radian : Double = (2*M_PI)*Double(i+1)/Double(numberOfMenuButtons)
            let radianOption: Double = (M_PI/2) + 2*(M_PI/Double(self.menuButtons.count))
        
            let centerX: CGFloat = centerOfCloseButton.x + (2 * frameOfCloseButton.width) * CGFloat(cos(radian - radianOption))
            let centerY: CGFloat = centerOfCloseButton.y + (2 * frameOfCloseButton.width) * CGFloat(sin(radian - radianOption))
            
            menuButton.center = CGPoint(x: centerX, y: centerY)
            
            label.center = CGPoint(x: menuButton.center.x, y: menuButton.center.y + menuButton.frame.size.height * 1 / 2 + 5)
            
            menuButton.addTarget(self, action: #selector(menuItemAction), forControlEvents: .TouchUpInside)
            
            
            self.addSubview(menuButton)
            self.addSubview(label)
            label.hidden = true
            menuButton.hidden = true
            
        }
        
        
    }
    
    func menuItemAction(sender: UIButton!) {
        self.closeButton.enabled = false
        self.closeButton.adjustsImageWhenDisabled = false
        
        for i in 0..<self.menuButtons.count {
            if sender.tag == i + 1 {
                //button
                let beginPosition = self.viewWithTag(i+1)?.center
                self.viewWithTag(i+1)?.hidden = false
                
                //label
                self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 1
                self.viewWithTag(self.menuButtons.count+i+1)?.hidden = false
                
                UIView.animateWithDuration(0.4, animations: {
                    //button
                    self.viewWithTag(i+1)?.center = self.closeButton.center
                    //label
                    self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 0
                    
                    }, completion: { (complete) in
                        self.closeButton.enabled = true
                        self.viewWithTag(self.menuButtons.count+i+1)?.hidden = true
                        UIView.animateWithDuration(0.3, animations: {
                            self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(0.2, 0.2)
                            self.viewWithTag(i+1)?.alpha = 0.2
                            }, completion: { (complete) in
                                self.closeViewAction(sender)
                                self.viewWithTag(i+1)?.center = beginPosition!
                                self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(1, 1)
                                self.viewWithTag(i+1)?.alpha = 1
                                self.viewWithTag(i+1)?.hidden = true
                                
                        })
                })
                
                
                
            } else {
                //button
                self.viewWithTag(i+1)?.alpha = 1
                self.viewWithTag(i+1)?.hidden = false
                
                //label
                self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 1
                self.viewWithTag(self.menuButtons.count+i+1)?.hidden = false
                UIView.animateWithDuration(0.4, animations: {
                    //button
                    self.viewWithTag(i+1)?.alpha = 0
                    
                    //label
                    self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 0
                    }, completion: { (complete) in
                        //button
                        self.viewWithTag(i+1)?.hidden = true
                        //label
                        self.viewWithTag(self.menuButtons.count+i+1)?.hidden = true
                })
            }
        }
        
    }
    
    func closeViewAction(sender: UIButton!) {
        
        
        
        if sender == self.closeButton {
            for i in 0..<self.menuButtons.count {
                //button
                let beginPosition = self.viewWithTag(i+1)?.center
                self.viewWithTag(i+1)?.hidden = false
                
                //label
                let beginLabelPosition = self.viewWithTag(self.menuButtons.count+i+1)?.center
                self.viewWithTag(self.menuButtons.count+i+1)?.hidden = false
                
                UIView.animateWithDuration(0.4, animations: {
                    //button
                    self.viewWithTag(i+1)?.center = self.closeButton.center
                    self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(0.2, 0.2)
                    self.viewWithTag(i+1)?.alpha = 0.2
                    
                    //label
                    self.viewWithTag(self.menuButtons.count+i+1)?.center = self.closeButton.center
                    self.viewWithTag(self.menuButtons.count+i+1)?.transform = CGAffineTransformMakeScale(0.2, 0.2)
                    self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 0.2
                    }, completion: { (complete) in
                        //button
                        self.viewWithTag(i+1)?.center = beginPosition!
                        self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(1, 1)
                        self.viewWithTag(i+1)?.alpha = 1
                        self.viewWithTag(i + 1)?.hidden = true
                        
                        //label
                        self.viewWithTag(self.menuButtons.count+i+1)?.center = beginLabelPosition!
                        self.viewWithTag(self.menuButtons.count+i+1)?.transform = CGAffineTransformMakeScale(1, 1)
                        self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 1
                        self.viewWithTag(self.menuButtons.count+i+1)?.hidden = true
                        
                })
                
            }
        }
        
        
        
        if let delegate = self.delegate {
            delegate.closeButtonAction()
        }
    }
    
    func setAnimationBegin() {
        for i in 0..<self.menuButtons.count {
            
            let finishPosition = self.viewWithTag(i+1)?.center
            let beginPosition = self.closeButton.center
            
            let finishLabelPosition = self.viewWithTag(self.menuButtons.count + i + 1)?.center
            
            //button
            self.viewWithTag(i+1)?.center = beginPosition
            self.viewWithTag(i+1)?.alpha = 0
            self.viewWithTag(i+1)?.hidden = false
            self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(0.2, 0.2)
            
            //label
            self.viewWithTag(self.menuButtons.count + i + 1)?.center = beginPosition
            self.viewWithTag(self.menuButtons.count + i + 1)?.alpha = 0
            self.viewWithTag(self.menuButtons.count + i + 1)?.hidden = false
            self.viewWithTag(self.menuButtons.count + i + 1)?.transform = CGAffineTransformMakeScale(0.2, 0.2)
            
            UIView.animateWithDuration(0.4, animations: {
                //button
                self.viewWithTag(i+1)?.alpha = 1
                self.viewWithTag(i+1)?.center = finishPosition!
                self.viewWithTag(i+1)?.transform = CGAffineTransformMakeScale(1, 1)
                
                //label
                self.viewWithTag(self.menuButtons.count+i+1)?.alpha = 1
                self.viewWithTag(self.menuButtons.count+i+1)?.center = finishLabelPosition!
                self.viewWithTag(self.menuButtons.count+i+1)?.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (complete) in
                    //button
                    self.viewWithTag(i+1)?.xYShake(( -(finishPosition?.x)! + beginPosition.x)/30, moveY: (-(finishPosition?.y)! + beginPosition.y)/30)
                    
                    //label
                    self.viewWithTag(self.menuButtons.count+i+1)?.xYShake(( -(finishPosition?.x)! + beginPosition.x)/30, moveY: (-(finishPosition?.y)! + beginPosition.y)/30)
                    
            })
        }
    }
    
}

