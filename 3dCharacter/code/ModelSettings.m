//
//  ModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "ModelSettings.h"

@implementation ModelSettings

- (id) initWithType: (enum modelType) theType andIndex: (int) theIndex andColor:(UIColor*) theColor
{
    if(self = [super init])
    {
        type = theType;
        templateIndex = theIndex;
        color = theColor;
    }
    return self;
}

@end
