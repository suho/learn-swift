//
//  Human.m
//  ObjectiveC-Ex3-Class
//
//  Created by Mylo Ho on 9/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Human.h"

@interface Human() {
    
}

@end

@implementation Human

@synthesize address = _address;

-(id) init {
    if (self = [super init]) {
        name = @"No Name";
        gender = @"Unknow";
        age = 0;
        self.address = @"No Address";
    }
    return self;
}

-(NSString*) getName {
    return name;
}

-(NSString*) getGender {
    return gender;
}

-(int) getAge {
    return age;
}

-(void) setName:(NSString *)_name {
    name = _name;
}

-(void) setGender:(NSString *)_gender {
    gender = _gender;
}

-(void) setAge:(int)_age {
    age = _age;
}

-(void) showInfo {
    NSLog(@"%@ - %@ - %d - %@", name, gender, age, _address);
}


@end

