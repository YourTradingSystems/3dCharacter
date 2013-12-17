//
//  AvatarModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "AvatarModelSettings.h"

@implementation AvatarModelSettings

@synthesize body, hair, skin, top, bottom, shoes, glasses;

-(void) setBody:(ModelSettings *)aBody
{
    if (body != aBody)
    {
        ModelSettings* oldBody = body;
        body = aBody;
        [self compareAndRaiseChanges:@"body" oldSettings: oldBody withNewSettings:body];
    }
}

-(void) setHair:(ModelSettings *)aHair
{
    if(hair != aHair)
    {
        ModelSettings* oldHair = hair;
        hair = aHair;
        [self compareAndRaiseChanges:@"hair" oldSettings:oldHair withNewSettings:hair];
    }
}

-(void) setSkin:(ModelSettings *)aSkin
{
    if(skin != aSkin)
    {
        ModelSettings* oldSkin = skin;
        skin = aSkin;
        [self compareAndRaiseChanges:@"skin" oldSettings:oldSkin withNewSettings:skin];
    }
}

-(void) setTop:(ModelSettings *)aTop
{
    if(top != aTop)
    {
        ModelSettings* oldTop = skin;
        top = aTop;
        [self compareAndRaiseChanges:@"top" oldSettings:oldTop withNewSettings:top];
    }
}

-(void) setBottom:(ModelSettings *)abottom
{
    if(bottom != abottom)
    {
        ModelSettings* oldbottom = bottom;
        bottom = abottom;
        [self compareAndRaiseChanges:@"bottom" oldSettings:oldbottom withNewSettings:bottom];
    }
}

-(void) setShoes:(ModelSettings *)aShoes
{
    if(shoes != aShoes)
    {
        ModelSettings* oldshoes = shoes;
        shoes = aShoes;
        [self compareAndRaiseChanges:@"shoes" oldSettings:oldshoes withNewSettings:shoes];
    }
}


-(void) setGlasses:(ModelSettings *)aGlasses
{
    if(glasses != aGlasses)
    {
        ModelSettings* oldglasses = glasses;
        glasses = aGlasses;
        [self compareAndRaiseChanges:@"glasses" oldSettings:oldglasses withNewSettings:glasses];
    }
}

-(void) compareAndRaiseChanges:(NSString *)propertyName oldSettings:(ModelSettings *)oldSetting withNewSettings:(ModelSettings*) newSettings
{
    if (oldSetting == nil || [oldSetting.modelName compare:newSettings.modelName] != NSOrderedSame)
    {
        [self raiseModelChanged:propertyName settings:newSettings];
    }
    else
    {
        [self raiseColorChanged:propertyName settings:newSettings];
    }
}

-(void) raiseModelChanged:(NSString*) propertyName settings: (ModelSettings*) modelSettings
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:modelSettings forKey:propertyName];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"modelChanged" object:nil userInfo:userInfo];
}

-(void) raiseColorChanged:(NSString*) propertyName settings: (ModelSettings*) modelSettings
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:modelSettings forKey:propertyName];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"colorChanged" object:nil userInfo:userInfo];
}


@end
