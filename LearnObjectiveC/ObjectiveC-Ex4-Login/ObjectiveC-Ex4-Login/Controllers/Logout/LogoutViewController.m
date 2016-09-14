//
//  LogoutViewController.m
//  ObjectiveC-Ex4-Login
//
//  Created by Mylo Ho on 9/14/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "LogoutViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLabel.text = [NSString stringWithFormat:@"Hello %@", _userName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logOutAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
