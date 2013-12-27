//
//  ModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "ModelSettings.h"

@implementation ModelSettings

@synthesize type, modelName, color;

- (id) initWithType: (enum modelType) theType andName: (NSString*) theName andColor:(UIColor*) theColor;
{
    if(self = [super init])
    {
        type = theType;
        modelName = theName;
        color = theColor;
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary *)theDictionary
{
    enum modelType theType = [self stringToModelType:[theDictionary objectForKey:@"type"]];
    NSString* theModelName = [theDictionary objectForKey:@"modelName"];
    UIColor* theColor = [self getColorFromDictionary: [theDictionary objectForKey:@"color"]];
    
    return [self initWithType:theType andName:theModelName andColor: theColor];
}

-(UIColor*) getColorFromDictionary: (NSDictionary*) theDictionary
{
    int r = [(NSString*)[theDictionary objectForKey:@"red"] intValue];
    int g = [(NSString*)[theDictionary objectForKey:@"green"] intValue];
    int b = [(NSString*)[theDictionary objectForKey:@"blue"] intValue];
    int a = [(NSString*)[theDictionary objectForKey:@"alpha"] intValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

- (NSDictionary*) toDictionary
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue;
    CGFloat alpha;
    [color getRed:&red green:&green blue:&blue alpha: &alpha];
    return @{@"type": [self modelTypeToString:type],
             @"modelName": modelName,
             @"color": @{@"red": [NSString stringWithFormat: @"%d", (int)(255.0 * red)],
                         @"green": [NSString stringWithFormat: @"%d", (int)(255.0 * green)],
                         @"blue": [NSString stringWithFormat: @"%d", (int)(255.0 * blue)],
                         @"alpha": [NSString stringWithFormat:@"%d", (int)(255.0 * alpha)]}};
}

-(NSString*) modelTypeToString: (enum modelType) modelType
{
    return [NSString stringWithFormat:@"%d", modelType];
//    switch(modelType)
//    {
//        case body: return @"BODY";
//        case skin: return @"SKIN";
//        case hair: return @"HAIR";
//        case top: return @"TOP";
//        case bottom: return @"BOTTOM";
//        case shoes: return @"SHOES";
//        case glasses: return @"GLASSES";
//        default: return nil;
//    }
}

-(enum modelType) stringToModelType: (NSString*) stringType
{
    return [stringType intValue];
//    if([stringType compare:@"BODY"] == NSOrderedSame)
//        return body;
//    if([stringType compare:@"SKIN"] == NSOrderedSame)
//        return skin;
//    if([stringType compare:@"HAIR"] == NSOrderedSame)
//        return hair;
//    if([stringType compare:@"TOP"] == NSOrderedSame)
//        return top;
//    if([stringType compare:@"BOTTOM"] == NSOrderedSame)
//        return bottom;
//    if([stringType compare:@"SHOES"] == NSOrderedSame)
//        return shoes;
//    if([stringType compare:@"GLASSES"] == NSOrderedSame)
//        return glasses;
//    return none;
}

@end
