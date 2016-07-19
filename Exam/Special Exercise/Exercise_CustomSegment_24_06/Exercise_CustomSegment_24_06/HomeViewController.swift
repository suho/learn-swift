//
//  HomeViewController.swift
//  Exercise_CustomSegment_24_06
//
//  Created by Mylo Ho on 6/26/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        label = UILabel(frame: CGRect(x: screenWidth/3, y: 300, width: screenWidth/3, height: 100))
        label.text = "Monthly"
        label.textAlignment = .Center
        self.view.addSubview(label)
        
        let customSegmentView = NSBundle.mainBundle().loadNibNamed("CustomSegmentView", owner: nil, options: nil).last as! CustomSegmentView
        customSegmentView.delegate = self
    
        customSegmentView.frame = CGRect(x: 10, y: 100, width: 300, height: 40)
        customSegmentView.contentView.layer.cornerRadius = customSegmentView.contentView.frame.size.width / 21
        customSegmentView.contentView.clipsToBounds = true
        customSegmentView.contentView.layer.borderWidth = 2
        customSegmentView.contentView.layer.borderColor = UIColor.brownColor().CGColor
        customSegmentView.availableView.layer.cornerRadius = customSegmentView.availableView.frame.size.width / 7
        customSegmentView.availableView.clipsToBounds = true
        customSegmentView.availableView.layer.borderWidth = 2
        customSegmentView.availableView.layer.borderColor = UIColor.brownColor().CGColor
        self.view.addSubview(customSegmentView)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: CustomSegmentDelegate {
    func setLabelText(text: String) {
        self.label.text = text
    }
}
