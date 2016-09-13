//
//  HomeViewController.m
//  ObjectiveC-Ex-2-ShowName
//
//  Created by Mylo Ho on 9/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.textColor = [UIColor brownColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)showAction:(id)sender {
    NSString *name;
    if ([self.nameTextField.text isEqualToString:@""]) {
        self.nameLabel.text = @"Please Input Name!!";
    } else {
        name = self.nameTextField.text;
        self.nameLabel.text = [NSString stringWithFormat:@"Hello %@", name];
    }
}
@end
