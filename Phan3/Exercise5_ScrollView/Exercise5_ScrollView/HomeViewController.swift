//
//  HomeViewController.swift
//  Exercise5_ScrollView
//
//  Created by Mylo Ho on 6/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = Int(screenSize.width)
        let myViewWidth = Int((screenWidth-20)/3)
        let myViewHeight = Int((screenWidth-20)/3)*(7/6)
        
        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        
        self.contentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: myViewHeight))
        
        let countOfImage = 100
        
        let n = countOfImage
        
        let randomNumber = Int(arc4random_uniform(UInt32(n)-1))
        
        for i in 0..<n {
            let myView = MyView(frame: CGRect(x: 5 + (myViewWidth + 5)*(i % 3), y: 5 + (myViewHeight + 5)*(i/3), width: myViewWidth, height: myViewHeight))
            if i == randomNumber{
                myView.labelName.text = "BOSS"
            }
            self.contentView.addSubview(myView)
        }
        
        self.contentView.frame.size.height = CGFloat(5 + (myViewHeight + 5)*((n % 3) == 0 ? n/3 : (n/3 + 1)))
        
        if self.contentView.frame.size.height < screenSize.height {
            self.contentView.frame.origin.y = (screenSize.height - self.contentView.frame.size.height)/2
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.contentView.frame.size.height/10)
        }
        
        self.scrollView.contentSize = contentView.bounds.size
        
        self.scrollView.addSubview(contentView)
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
