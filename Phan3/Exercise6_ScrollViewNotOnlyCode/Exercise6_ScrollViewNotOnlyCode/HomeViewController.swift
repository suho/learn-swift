//
//  HomeViewController.swift
//  Exercise6_ScrollViewNotOnlyCode
//
//  Created by Mylo Ho on 6/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAvatarView = NSBundle.mainBundle().loadNibNamed("MyAvatarView", owner: nil, options: nil).last as! MyAvatarView
        myAvatarView.frame = CGRect(x: 50, y: 100, width: 100, height: 120)
        myAvatarView.myAvatarImage.image = UIImage(named: "3")
        myAvatarView.labelMyName.text = "BOSS"
        print(myAvatarView.myAvatarImage.frame)
        myAvatarView.myAvatarImage.frame.size.width = 100
        print(myAvatarView.myAvatarImage.frame)
        self.view.addSubview(myAvatarView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
