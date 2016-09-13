//
//  Human.h
//  ObjectiveC-Ex3-Class
//
//  Created by Mylo Ho on 9/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject {
    NSString *name;
    NSString *gender;
    int age;
}

@property (nonatomic) NSString *address;

-(NSString*) getName;
-(NSString*) getGender;
-(int) getAge;

-(void) setName: (NSString*) _name;
-(void) setGender: (NSString*) _gender;
-(void) setAge: (int) _age;

-(void) showInfo;

@end
