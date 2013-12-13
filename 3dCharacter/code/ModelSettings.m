//
//  ModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "ModelSettings.h"

@implementation ModelSettings

@synthesize type, modelName, color;

- (id) initWithType: (enum modelType) theType andName: (NSString*) theName andColor:(UIColor*) theColor;
{
    if(self = [super init])
    {
        type = theType;
        modelName = theName;
        color = theColor;
    }
    return self;
}

@end
