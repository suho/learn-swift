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
        
        self.contentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: myViewHeight))
        let n = 120
        for i in 0..<n {
            let myView = MyView(frame: CGRect(x: 5 + (myViewWidth + 5)*(i % 3), y: 5 + (myViewHeight + 5)*(i/3), width: myViewWidth, height: myViewHeight))
            self.contentView.addSubview(myView)
        }
        self.contentView.frame.size.height = CGFloat(5 + (myViewHeight + 5)*(n/3))
        self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        self.scrollView.contentSize = contentView.bounds.size
        
        self.scrollView.addSubview(contentView)
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
