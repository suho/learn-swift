//
//  HomeViewController.m
//  Objective-C-Ex1
//
//  Created by Mylo Ho on 9/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () {
    
bool isStop;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isStop = false;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(setTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view == self.view) {
        isStop = !isStop;
    }
}

-(void) setTime {
    if (!isStop) {
        self.helloWorldLabel.text = [NSString stringWithFormat:@"%@", [NSDate date]];
    }
}

@end
