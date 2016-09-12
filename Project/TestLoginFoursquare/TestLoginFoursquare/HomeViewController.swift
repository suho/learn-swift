//
//  HomeViewController.swift
//  TestLoginFoursquare
//
//  Created by Mylo Ho on 8/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import FSOAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var tokenLabel: UILabel!
    let clientID = "ATPAQMJVFOQPGJ2ZANDMTAOMNGT3ZFUFNW0E35FIE40R5VU0"
    let uriCallBack = "testLoginFoursquare://authorized"
    let urlScheme = "testloginfoursquare"
    let clientSecret = "SBHN014V21FKCKN3YZFXFHNEXTTIRP12BTVOPVSRZQNS2TDJ"
    var accessCode: String = ""
    var token: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectFourSquareAction(sender: AnyObject) {
        let statusCode: FSOAuthStatusCode = FSOAuth.authorizeUserUsingClientId(self.clientID, nativeURICallbackString: self.uriCallBack, universalURICallbackString: "", allowShowingAppStore: true)

        switch statusCode {
        case .Success:
            print("Success!!!")
        default:
            print("Fail!!")
        }

    }

    func handleUrl(url: NSURL) {
        if url.scheme == self.urlScheme {
            var errorCode: FSOAuthErrorCode = .None
            let accessCode = FSOAuth.accessCodeForFSOAuthURL(url, error: &errorCode)
            if errorCode == .None {
                self.accessCode = accessCode
                self.getTokken()
                print("AccessCode: \(accessCode)")
            } else {
                print("AccessCode Have Error!!!")
            }
        }
    }

    func getTokken() {
        FSOAuth.requestAccessTokenForCode(self.accessCode, clientId: clientID, callbackURIString: uriCallBack, clientSecret: clientSecret) { (authToken, requestCompletion, errorCode) in
            if requestCompletion {
                if errorCode == .None {
                    self.token = authToken
                    self.tokenLabel.text = self.token
                } else {
                    print("Token Error")
                }
            }
        }
    }

}
