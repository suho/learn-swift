//
//  HomeViewController.swift
//  Exercise7_SliderBarWithProtocol
//
//  Created by Mylo Ho on 6/22/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var textFieldPercent: UITextField!
    
    @IBAction func buttonChangeSlider(sender: AnyObject) {
        self.customSliderView.setPercent(self.textFieldPercent.text!)
        self.textFieldPercent.resignFirstResponder()
    }
    
    let customSliderView = NSBundle.mainBundle().loadNibNamed("CustomSliderView", owner: nil, options: nil).last as! CustomSliderView

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.size.width
        let screenHeight = screenSize.size.height
        self.customSliderView.frame = CGRect(x: screenWidth/2 - 5, y: screenHeight/2 - 100, width: 10, height: 200)
        self.customSliderView.ballImage.image = UIImage(named: "ball")
        self.customSliderView.ballLabel.text = "50%"
        self.textFieldPercent.text = "50%"
        self.customSliderView.delegate = self
        self.view.addSubview(self.customSliderView)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.customSliderView.touchesMoved(touches, withEvent: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension HomeViewController: CustomSliderDelegate {
    func getPercent(percent: String) {
        self.textFieldPercent.text = percent
    }
    func messageError(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}