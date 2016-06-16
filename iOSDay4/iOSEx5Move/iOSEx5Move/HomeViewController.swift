//
//  HomeViewController.swift
//  iOSEx5Move
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moveObject: UIImageView!
    
    var location = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //self.isCollisionBackground()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch! = touches.first! as UITouch
        location = touch.locationInView(self.view)
        if isTouchedObject(location) {
            self.moveObject.center = location
        } else {
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isTouchedObject(touch: CGPoint) -> Bool {
        let frameImage = self.moveObject.frame
        let leftImage = frameImage.origin.x
        let widthImage = frameImage.size.width
        let topImage = frameImage.origin.y
        let heightImage = frameImage.size.height
        
        if (touch.x >= leftImage) && (touch.x <= widthImage + leftImage) && (touch.y >= topImage) && (touch.y <= heightImage + topImage) {
            return true
        } else {
            return false
        }
    }
    
//    func isCollisionBackground() -> Bool {
//        let frameBackground = view.frame
//        let widthBackground = frameBackground.width
//        let heightBackground = frameBackground.height
//        
//        let frameImage = self.moveObject.frame
//        let leftImage = frameImage.origin.x
//        let widthImage = frameImage.size.width
//        let topImage = frameImage.origin.y
//        let heightImage = frameImage.size.height
//        
//        if leftImage < 0 {
//            self.moveObject.frame.origin.x = 0
//            return true
//        }
//        if topImage < 0 {
//            self.moveObject.frame.origin.y = 0
//            return true
//        }
//        
//        if leftImage + widthImage > widthBackground {
//            self.moveObject.frame.origin.x = widthBackground - widthImage + 0
//            return true
//        }
//        
//        if topImage + heightImage > heightBackground {
//            self.moveObject.frame.origin.y = heightBackground - heightImage + 0
//            return true
//        }
//        
//        return false
//        
//    }

}
