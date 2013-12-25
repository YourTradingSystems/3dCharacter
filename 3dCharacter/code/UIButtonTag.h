//
//  UIButtonTag.h
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelSettings.h"

@interface UIButtonTag : UIButton
{
    @private ModelSettings* _tagSettings;
    @private BOOL _choosed;
}

@property (atomic, retain ) ModelSettings* tagSettings;
@property (atomic, setter = setChoosed:) BOOL choosed;

@end
