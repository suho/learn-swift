//
//  Man.m
//  ObjectiveC-Ex3-Class
//
//  Created by Mylo Ho on 9/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import "Man.h"

@implementation Man

@synthesize isGay = _isGay;

-(id) init {
    if (self = [super init]) {
        _isGay = true;
    }
    return self;
}

-(void) showInfo {
    [super showInfo];
    NSLog(@"Gay: %@", _isGay? @"Yes": @"No");
}

@end
