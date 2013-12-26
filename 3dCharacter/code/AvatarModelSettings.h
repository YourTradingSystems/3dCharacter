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
    NSDictionary* _body;
    ModelSettings* _hair;
    ModelSettings* _skin;
    ModelSettings* _top;
    ModelSettings* _bottom;
    ModelSettings* _shoes;
    ModelSettings* _glasses;
}

@property (nonatomic, retain, setter = setBody:) NSDictionary* body;
@property (nonatomic, retain, setter = setHair:) ModelSettings* hair;
@property (nonatomic, retain, setter = setSkin:) ModelSettings* skin;
@property (nonatomic, retain, setter = setTop:) ModelSettings* top;
@property (nonatomic, retain, setter = setBottom:) ModelSettings* bottom;
@property (nonatomic, retain, setter = setShoes:) ModelSettings* shoes;
@property (nonatomic, retain, setter = setGlasses:) ModelSettings* glasses;

-(void) compareAndRaiseChanges:(NSString *)propertyName oldSettings:(ModelSettings *)oldSetting withNewSettings:(ModelSettings*) newSettings;

@end
