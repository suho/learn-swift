//
//  HomeViewController.m
//  ObjectiveC-Ex3-Class
//
//  Created by Mylo Ho on 9/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    human = [[Human alloc] init];
    [human setName:@"ABC"];
    human.address = @"Da Nang";
    
    Man *man = [[Man alloc] init];
    man.isGay = false;
    [man showInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)showInfomationAction:(id)sender {
    [human showInfo];
}
@end
