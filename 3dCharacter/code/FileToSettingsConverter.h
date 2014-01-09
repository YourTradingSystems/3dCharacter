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
    @private BOOL male;
    NSDictionary* maleSettings;
    NSDictionary* femaleSettings;
    //@public NSDictionary* dicNameColor;
}

+ (id) instance;

-(NSObject*) getSettings:(NSString*) fileName;
-(NSArray*) getTypeSettings: (enum modelType) type;
-(void) setMale: (BOOL) value;

@end
