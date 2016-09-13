//
//  HomeViewController.h
//  ObjectiveC-Ex-2-ShowName
//
//  Created by Mylo Ho on 9/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)showAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
