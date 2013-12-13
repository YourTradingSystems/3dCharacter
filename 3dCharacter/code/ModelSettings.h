//
//  ModelSettings.h
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <Foundation/Foundation.h>

enum modelType
{
    body,
    skin,
    hair,
    top,
    bottom,
    shoes,
    glasses
};

@interface ModelSettings : NSObject
{
    @public enum modelType type;
    @public int templateIndex;
    @public UIColor* color;
}

- (id) initWithType: (enum modelType) theType andIndex: (int) theIndex andColor:(UIColor*) theColor;

@end
