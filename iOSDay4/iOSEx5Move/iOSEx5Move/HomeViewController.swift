//
//  HomeViewController.swift
//  iOSEx5Move
//
//  Created by Mylo Ho on 6/16/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moveObject: UIImageView!
    
    var location =

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("di chuyen")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("tha")
    }
   
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("cancel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
