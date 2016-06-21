//
//  HomeViewController.swift
//  Exercise1SubView
//
//  Created by Mylo Ho on 6/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add MyView
        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 120))
        self.view.addSubview(myView)
        
        //add ImageView
        let myViewImage = UIImageView(image: UIImage(named: "1"))
        myViewImage.frame = CGRect(x: 0, y: 0, width: myView.frame.size.width, height: myView.frame.size.height - myView.frame.size.height/6)
        myView.addSubview(myViewImage)
        
        //add Label
        let labelName = UILabel(frame: CGRect(x: 0, y: myView.frame.size.height - myView.frame.size.height/6, width: myView.frame.size.width, height: myView.frame.size.width/6))
        labelName.text = "John Smith"
        labelName.textAlignment = NSTextAlignment.Center
        labelName.backgroundColor = UIColor.brownColor()
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
    
    func showMessage(sender: UIButton) {
        print("You Touched \(sender.tag)")
    }

}
