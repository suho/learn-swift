//
//  HomeViewController.swift
//  Exercise4_SubClassMyView
//
//  Created by Mylo Ho on 6/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = MyView(frame: CGRectMake(50, 100, 150, 180))
        myView.myViewImage.image = UIImage(named: "3")
        myView.labelName.text = "Boss"
        self.view.addSubview(myView)
        
        let anotherMyView = MyView(frame: CGRect(x: 50, y: 350, width: 100, height: 120))
        self.view.addSubview(anotherMyView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
