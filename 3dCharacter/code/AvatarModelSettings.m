//
//  AvatarModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "AvatarModelSettings.h"

@implementation AvatarModelSettings

@synthesize body = _body, hair = _hair, skin = _skin, top = _top, bottom = _bottom, shoes = _shoes, glasses = _glasses;

-(void) setBody:(ModelSettings *)aBody
{
    if (_body != aBody)
    {
        ModelSettings* oldBody = _body;
        _body = aBody;
        [self compareAndRaiseChanges:@"body" oldSettings: oldBody withNewSettings:_body];
    }
}

-(void) setHair:(ModelSettings *)aHair
{
    if(_hair != aHair)
    {
        ModelSettings* oldHair = _hair;
        _hair = aHair;
        [self compareAndRaiseChanges:@"hair" oldSettings:oldHair withNewSettings:_hair];
    }
}

-(void) setSkin:(ModelSettings *)aSkin
{
    if(_skin != aSkin)
    {
        ModelSettings* oldSkin = _skin;
        _skin = aSkin;
        [self compareAndRaiseChanges:@"skin" oldSettings:oldSkin withNewSettings:_skin];
    }
}

-(void) setTop:(ModelSettings *)aTop
{
    if(_top != aTop)
    {
        ModelSettings* oldTop = _skin;
        _top = aTop;
        [self compareAndRaiseChanges:@"top" oldSettings:oldTop withNewSettings:_top];
    }
}

-(void) setBottom:(ModelSettings *)aBottom
{
    if(_bottom != aBottom)
    {
        ModelSettings* oldbottom = _bottom;
        _bottom = aBottom;
        [self compareAndRaiseChanges:@"bottom" oldSettings:oldbottom withNewSettings:_bottom];
    }
}

-(void) setShoes:(ModelSettings *)aShoes
{
    if(_shoes != aShoes)
    {
        ModelSettings* oldshoes = _shoes;
        _shoes = aShoes;
        [self compareAndRaiseChanges:@"shoes" oldSettings:oldshoes withNewSettings:_shoes];
    }
}


-(void) setGlasses:(ModelSettings *)aGlasses
{
    if(_glasses != aGlasses)
    {
        ModelSettings* oldglasses = _glasses;
        _glasses = aGlasses;
        [self compareAndRaiseChanges:@"glasses" oldSettings:oldglasses withNewSettings:_glasses];
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
