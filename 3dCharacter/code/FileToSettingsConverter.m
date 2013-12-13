//
//  FileToSettingsConverter.m
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "FileToSettingsConverter.h"
#import "ModelSettings.h"

@interface FileToSettingsConverter()

- (NSDictionary*) initializeDictionary;

@end


@implementation FileToSettingsConverter

+ (id) instance {
    static FileToSettingsConverter *instance = nil;
    @synchronized(self)
    {
        if (instance == nil)
            instance = [[self alloc] init];
    }
    return instance;
}

- (id) init {
    if (self = [super init])
    {
        dicNameColor = [self initializeDictionary];
    }
    return self;
}

- (NSDictionary*) initializeDictionary
{
    return @{@"skin1" : [[ModelSettings alloc] initWithType: skin
                                                   andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin2" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin3" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin4" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                    andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin5" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin6" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin7" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin8" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin9" : [[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin10" : [[ModelSettings alloc] initWithType: skin
                                                     andName:@"skin"
                                                    andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"skin11" :[[ModelSettings alloc] initWithType: skin
                                                    andName:@"skin"
                                                   andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],};
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (ModelSettings*) getSettings: (NSString*) fileName
{
    return (ModelSettings*)dicNameColor[fileName];
}

@end