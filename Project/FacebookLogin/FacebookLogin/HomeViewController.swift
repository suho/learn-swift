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
        loginFacebookButton.loginBehavior = .Browser
        loginFacebookButton.readPermissions = ["public_profile", "email"]
        loginFacebookButton.delegate = self
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            print(accessToken.userID)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        guard let result = result, token = result.token else {
            return
        }
        print(token.appID)
        print(token.userID)
        print(token.tokenString)
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {

    }
}
