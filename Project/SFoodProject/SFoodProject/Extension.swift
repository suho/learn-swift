//
//  Extension.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func actionWhenShowKeyBoard() -> Void {
        var frame = self.frame
        if frame.origin.y < 0 {
            return
        } else {
            frame.origin.y = -140
            UIView.animateWithDuration(0.3, animations: {
                self.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
    
    func actionWhenHideKeyBoard() -> Void {
        var frame = self.frame
        if frame.origin.y == 0 {
            return
        } else {
            frame.origin.y = 0
            UIView.animateWithDuration(0.5, animations: {
                self.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
}

extension UIViewController {
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}