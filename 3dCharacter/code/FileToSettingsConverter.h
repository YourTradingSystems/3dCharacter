//
//  FileToSettingsConverter.h
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelSettings.h"

@interface FileToSettingsConverter : NSObject
{
    @public NSDictionary* dicNameColor;
}

+ (id) instance;

-(ModelSettings*) getScinSettings:(NSString*) fileName;

@end
