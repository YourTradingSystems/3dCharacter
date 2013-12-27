//
//  BodyModelSettings.h
//  3dCharacter
//
//  Created by Vasya on 12/27/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "ModelSettings.h"

@interface BodyModelSettings : ModelSettings
{
    NSDictionary* boneSizes;
}

@property (nonatomic, retain) NSDictionary* boneSizes;

@end
