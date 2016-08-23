//
//  HomeViewController.swift
//  FacebookLogin
//
//  Created by Mylo Ho on 8/23/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginFacebookButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if FBSDKAccessToken.currentAccessToken() != nil {

        } else {
            loginFacebookButton.loginBehavior = .Web
            loginFacebookButton.readPermissions = ["public_profile"]
            loginFacebookButton.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {

    }
}
