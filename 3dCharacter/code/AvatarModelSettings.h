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

@property (nonatomic, setter = setBody:) ModelSettings* body;
@property (nonatomic, setter = setHair:) ModelSettings* hair;
@property (nonatomic, setter = setSkin:) ModelSettings* skin;
@property (nonatomic, setter = setTop:) ModelSettings* top;
@property (nonatomic, setter = setBottom:) ModelSettings* bottom;
@property (nonatomic, setter = setShoes:) ModelSettings* shoes;
@property (nonatomic, setter = setGlasses:) ModelSettings* glasses;

//-(void) setBody:(ModelSettings *)body;
-(void) raiseModelChanged:(NSString*) propertyName settings: (ModelSettings*) modelSettings;
-(void) raiseColorChanged:(NSString*) propertyName settings: (ModelSettings*) modelSettings;
-(void) compareAndRaiseChanges:(NSString *)propertyName oldSettings:(ModelSettings *)oldSetting withNewSettings:(ModelSettings*) newSettings;

@end
