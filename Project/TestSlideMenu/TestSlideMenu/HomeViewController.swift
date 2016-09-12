//
//  HomeViewController.swift
//  TestSlideMenu
//
//  Created by Mylo Ho on 8/1/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import LGSideMenuController

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test"
        self.setLeftButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLeftButton() {
        let iconMenuImage = UIImage(named: "menu-icon")
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: iconMenuImage, style: .Done, target: self, action: #selector(self.showSlideBar))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func showSlideBar() {

    }

}
