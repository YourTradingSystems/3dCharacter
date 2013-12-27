//
//  BodyModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/27/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "BodyModelSettings.h"
#import "Point3d.h"

@implementation BodyModelSettings

@synthesize boneSizes;

- (id) initWithDictionary:(NSDictionary *)theDictionary
{
    if(self = [super initWithDictionary:theDictionary])
    {
        boneSizes = [self getDictionaryForBones: [theDictionary objectForKey:@"boneSizes"]];
    }
    return self;
}

- (NSDictionary*) getDictionaryForBones: (NSDictionary*) bonesDictionary
{
    NSMutableDictionary* dictionaryForBones = [[NSMutableDictionary alloc] init];
    for (NSString* key in bonesDictionary) {
        NSDictionary* dicPoint = [bonesDictionary objectForKey:key];
        float x = [[dicPoint objectForKey:@"x"] floatValue];
        float y = [[dicPoint objectForKey:@"y"] floatValue];
        float z = [[dicPoint objectForKey:@"z"] floatValue];
        Point3d* point3d = [[Point3d alloc] initWithX:x withY:y withZ:z];
        [dictionaryForBones setObject:point3d forKey:key];
    }
    return dictionaryForBones;
}

- (NSDictionary*) toDictionary
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue;
    CGFloat alpha;
    [color getRed:&red green:&green blue:&blue alpha: &alpha];
    return @{@"type": [super modelTypeToString:type],
             @"modelName": modelName,
             @"color": @{@"red": [NSString stringWithFormat: @"%d", (int)(255.0 * red)],
                         @"green": [NSString stringWithFormat: @"%d", (int)(255.0 * green)],
                         @"blue": [NSString stringWithFormat: @"%d", (int)(255.0 * blue)],
                         @"alpha": [NSString stringWithFormat:@"%d", (int)(255.0 * alpha)]},
             @"boneSizes": [self getBonesDictionary]};
}

- (NSDictionary*) getBonesDictionary
{
    NSMutableDictionary* bonesDictionary = [[NSMutableDictionary alloc] init];
    for (NSString* key in boneSizes) {
        Point3d* point3d = [boneSizes objectForKey:key];
        [bonesDictionary setObject:@{@"x": [NSString stringWithFormat: @"%f", point3d.x],
                                     @"y": [NSString stringWithFormat: @"%f", point3d.y],
                                     @"z": [NSString stringWithFormat: @"%f", point3d.z]} forKey:key];
    }
    return bonesDictionary;
}

@end