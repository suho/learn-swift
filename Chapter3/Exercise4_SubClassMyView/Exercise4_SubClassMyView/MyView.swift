//
//  MyView.swift
//  Exercise4_SubClassMyView
//
//  Created by Mylo Ho on 6/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    var myViewImage: UIImageView!
    var labelName: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView(frame: CGRect) {
        
        //add ImageView
        let random = Int(arc4random_uniform(5) + 1)
        self.myViewImage = UIImageView(image: UIImage(named: "\(random)"))
        self.myViewImage.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - frame.size.height/6)
        self.addSubview(self.myViewImage)
        
        //add Label
        let index = Int(arc4random_uniform(100) + 1)
        self.labelName = UILabel(frame: CGRect(x: 0, y: frame.size.height - frame.size.height/6, width: frame.size.width, height: frame.size.width/6))
        self.labelName.text = "Person ID: \(index)"
        self.labelName.textAlignment = NSTextAlignment.Center
        self.labelName.backgroundColor = UIColor.brownColor()
        self.labelName.textColor = UIColor.whiteColor()
        self.labelName.font = self.labelName.font.fontWithSize(13)
        self.addSubview(self.labelName)
        
        //add Button
        let button = UIButton()
        button.frame = self.bounds
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(showMessage), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    func showMessage() {
        print("You Touched \(labelName.text!)")
    }

}
