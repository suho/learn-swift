//
//  HomeViewController.swift
//  Exercise2_Draw_Ball
//
//  Created by Mylo Ho on 6/24/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ball = BallView(frame: CGRect(x: 50, y: 0, width: 100, height: 100))
        self.view.addSubview(ball)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInView(self.view)
        
        let randomSize = Int(arc4random_uniform(90) + 10)
        let randomSpeed = self.randomBetweenNumbers(0.0009, secondNum: 0.01)
        let randomVelocityX = self.randomBetweenNumbers(-1, secondNum: 1)
        let randomVelocityY = self.randomBetweenNumbers(-1, secondNum: 1)
        let randomColor = self.getRandomColor()
        
        let anotherBall = BallView(frame: CGRect(origin: location, size: CGSize(width: randomSize, height: randomSize)))
        anotherBall.speed = Double(randomSpeed)
        anotherBall.velocityX = randomVelocityX
        anotherBall.velocityY = randomVelocityY
        anotherBall.ballColor = randomColor
        self.view.addSubview(anotherBall)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

}

