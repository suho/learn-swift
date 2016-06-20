//
//  HomeViewController.swift
//  Exercise1SubView
//
//  Created by Mylo Ho on 6/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var touch: UITouch!
    var location = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add MyView
        let myView = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 120))
        self.view.addSubview(myView)
        
        //add ImageView
        let myViewImage = UIImageView(image: UIImage(named: "galaxy"))
        myViewImage.frame = CGRect(x: 0, y: 0, width: myView.frame.size.width, height: myView.frame.size.height - myView.frame.size.height/6)
        myView.addSubview(myViewImage)
        
        //add Label
        let labelName = UILabel(frame: CGRect(x: 0, y: myView.frame.size.height - myView.frame.size.height/6, width: myView.frame.size.width, height: myView.frame.size.width/6))
        labelName.text = "Name"
        labelName.textAlignment = NSTextAlignment.Center
        labelName.backgroundColor = UIColor.blackColor()
        labelName.textColor = UIColor.whiteColor()
        myView.addSubview(labelName)
        
        //add Button
        let button = UIButton()
        button.frame = myView.bounds
        button.backgroundColor = UIColor.clearColor()
        button.tag = 1
        button.addTarget(self, action: #selector(showMessage), forControlEvents: UIControlEvents.TouchUpInside)
        myView.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first! as UITouch
        location = touch.locationInView(self.view)
        
        if isTouchedMyView(location, myView: self.myView) {
            print("You Touch Me!!")
        }
    }*/
    
    /*func isTouchedMyView(touch: CGPoint, myView: UIView) -> Bool {
        
        let myViewFrame = myView.frame
        let myViewX = myViewFrame.origin.x
        let myViewWidth = myViewFrame.size.width
        let myViewY = myViewFrame.origin.y
        let myViewHeight = myViewFrame.size.height
        
        if (touch.x >= myViewX) && (touch.x <= myViewWidth + myViewX) && (touch.y >= myViewY) && (touch.y <= myViewHeight + myViewY) {
            return true
        } else {
            return false
        }
    }*/
    
    func showMessage(sender: UIButton) {
        print("You Touch \(sender.tag)")
    }

}
