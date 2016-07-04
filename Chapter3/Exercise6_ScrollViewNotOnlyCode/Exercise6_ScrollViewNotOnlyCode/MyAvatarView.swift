//
//  MyAvatarView.swift
//  Exercise6_ScrollViewNotOnlyCode
//
//  Created by Mylo Ho on 6/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class MyAvatarView: UIView {

    @IBOutlet weak var myAvatarImage: UIImageView!

    @IBOutlet weak var labelMyName: UILabel!

    @IBAction func tapButton(sender: AnyObject) {
        print("You touched \(labelMyName.text!)")
    }
    
}
