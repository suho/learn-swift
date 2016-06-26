//
//  HomeViewController.swift
//  Exercise1_DrawGraphs
//
//  Created by Mylo Ho on 6/24/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Do any additional setup after loading the view.
        let line = LineView(frame: CGRect(x: screenWidth/3, y: screenHeight/3, width: screenWidth/3, height: screenWidth/3))
        line.backgroundColor = UIColor.brownColor()
        self.view.addSubview(line)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
