//
//  LogoutViewController.h
//  ObjectiveC-Ex4-Login
//
//  Created by Mylo Ho on 9/14/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (nonatomic) NSString *userName;
- (IBAction)logOutAction:(id)sender;
@end
