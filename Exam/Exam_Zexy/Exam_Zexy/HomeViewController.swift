//
//  HomeViewController.swift
//  Exam_Zexy
//
//  Created by Mylo Ho on 7/7/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    
    let menuView = CustomMenuView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height))

    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButtons = self.setMenuButtons(5)
        self.menuView.menuButtons = menuButtons
        self.menuView.delegate = self
        self.view.addSubview(menuView)
        self.menuView.hidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMenuAction(sender: AnyObject) {
        self.menuView.alpha = 0
        self.menuView.hidden = false
        
        
        UIView.animateWithDuration(0.3, animations: {
            self.menuView.alpha = 1
            }, completion: { (complete) in
                self.menuView.setAnimationBegin()
        })
        
        
    }
    
    func setMenuButtons(total: Int) -> [UIButton] {
        var result = [UIButton]()
        for i in 0..<total {
            let menuButton = UIButton()
            if total > 5 && i >= 5{
                menuButton.setImage(UIImage(named: "but5"), forState: .Normal)
            } else {
                menuButton.setImage(UIImage(named: "but\(i+1)"), forState: .Normal)
            }
            result.append(menuButton)
            
        }
        return result
    }
    

}

extension HomeViewController: CustomMenuViewDelegate {
    func closeButtonAction() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.menuView.alpha = 0.1
            }, completion: { (complete) in
                self.menuView.hidden = true
        })
        
    }
    
}

