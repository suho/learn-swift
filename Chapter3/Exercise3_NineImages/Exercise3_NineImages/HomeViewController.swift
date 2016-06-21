//
//  HomeViewController.swift
//  Exercise3_NineImages
//
//  Created by Mylo Ho on 6/20/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let myViewWidth = Int((screenWidth-20)/3)
        let myViewHeight = Int((screenWidth-20)/3)*(7/6)
        
        for i in 0...8 {
            //add MyView
            let myView = UIView(frame: CGRect(x: 5 + (myViewWidth + 5)*(i % 3), y: 50 + (myViewHeight + 5)*(i/3) , width: myViewWidth, height: myViewHeight))
            self.view.addSubview(myView)
            
            //add ImageView
            let random = Int(arc4random_uniform(5) + 1)
            let myViewImage = UIImageView(image: UIImage(named: "\(random)"))
            myViewImage.frame = CGRect(x: 0, y: 0, width: myView.frame.size.width, height: myView.frame.size.height - myView.frame.size.height/6)
            myView.addSubview(myViewImage)
            
            //add Label
            let index = Int(arc4random_uniform(100) + 1)
            let labelName = UILabel(frame: CGRect(x: 0, y: myView.frame.size.height - myView.frame.size.height/6, width: myView.frame.size.width, height: myView.frame.size.width/6))
            labelName.text = "Person ID: \(index)"
            labelName.textAlignment = NSTextAlignment.Center
            labelName.backgroundColor = UIColor.brownColor()
            labelName.textColor = UIColor.whiteColor()
            labelName.font = labelName.font.fontWithSize(13)
            myView.addSubview(labelName)
            
            //add Button
            let button = UIButton()
            button.frame = myView.bounds
            button.backgroundColor = UIColor.clearColor()
            button.tag = index
            button.addTarget(self, action: #selector(showMessage), forControlEvents: UIControlEvents.TouchUpInside)
            myView.addSubview(button)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMessage(sender: UIButton) {
        print("You Touched Person With ID \(sender.tag)")
    }

}
