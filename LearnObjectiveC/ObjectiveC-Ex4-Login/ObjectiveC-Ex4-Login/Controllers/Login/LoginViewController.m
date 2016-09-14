//
//  LoginViewController.m
//  ObjectiveC-Ex4-Login
//
//  Created by Mylo Ho on 9/14/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.navigationController navigationBar] setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginAction:(id)sender {
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([userName isEqualToString:@"admin"] && [password isEqualToString:@"123456"]) {
        LogoutViewController *logOutVC = [[LogoutViewController alloc] initWithNibName:@"LogoutViewController" bundle:nil];
        logOutVC.userName = userName;
        [self.navigationController pushViewController:logOutVC animated:YES];
    } else {
        [self showErrorMessage];
    }
}

- (void)showErrorMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message"
                                                                             message:@"Invalid Username or Password"
                                                                      preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [alertController addAction:alertAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

@end
