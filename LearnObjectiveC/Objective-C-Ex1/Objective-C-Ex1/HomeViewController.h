//
//  HomeViewController.h
//  Objective-C-Ex1
//
//  Created by Mylo Ho on 9/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *helloWorldLabel;
- (void) setTime;
@end
