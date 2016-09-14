//
//  LoginViewController.h
//  ObjectiveC-Ex4-Login
//
//  Created by Mylo Ho on 9/14/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogoutViewController.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginAction:(id)sender;

@end
