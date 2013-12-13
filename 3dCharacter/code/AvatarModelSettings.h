//
//  AvatarModelSettings.h
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelSettings.h"

@interface AvatarModelSettings : NSObject
{
    ModelSettings* body;
    ModelSettings* hair;
    ModelSettings* skin;
    ModelSettings* top;
    ModelSettings* bottom;
    ModelSettings* shoes;
    ModelSettings* glasses;
}

@property (nonatomic) ModelSettings* body;
@property (nonatomic) ModelSettings* hair;
@property (nonatomic) ModelSettings* skin;
@property (nonatomic) ModelSettings* top;
@property (nonatomic) ModelSettings* bottom;
@property (nonatomic) ModelSettings* shoes;
@property (nonatomic) ModelSettings* glasses;

@end
