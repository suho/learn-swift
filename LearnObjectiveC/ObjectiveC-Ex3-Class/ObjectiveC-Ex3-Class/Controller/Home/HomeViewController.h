//
//  HomeViewController.h
//  ObjectiveC-Ex3-Class
//
//  Created by Mylo Ho on 9/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Human.h"
#import "Man.h"

@interface HomeViewController : UIViewController {
    Human *human;
}
- (IBAction)showInfomationAction:(id)sender;

@end
