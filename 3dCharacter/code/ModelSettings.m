//
//  ModelSettings.m
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "ModelSettings.h"

static int baseIndex = 0;

@implementation ModelSettings

@synthesize type, screenName, modelName, color, index;

-(id) initWithType: (enum modelType) theType andModel: (NSString*) theModel ansScreen: (NSString*) theScreen andColor:(UIColor*) theColor;
{
    if (self = [super init])
    {
        type = theType;
        modelName = theModel;
        screenName = theScreen;
        color = theColor;
        index = ++baseIndex;
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)theDictionary
{
    enum modelType theType = [self stringToModelType:[theDictionary objectForKey:@"type"]];
    NSString* theModelName = [self getModelNameFromDictionary:[theDictionary objectForKey:@"modelName"]];
    NSString* theScreenName = [self getScreenNameFromDictionary:[theDictionary objectForKey:@"screenName"]];
    UIColor* theColor = [self getColorFromDictionary: [theDictionary objectForKey:@"color"]];
    
    return [self initWithType:theType andModel:theModelName ansScreen:theScreenName andColor:theColor];
}

-(enum modelType) stringToModelType: (NSString*) stringType
{
    return [stringType intValue];
}

-(NSString*) getModelNameFromDictionary: (NSString*) theName
{
    if([theName compare:@""] == NSOrderedSame)
        return nil;
    return theName;
}

-(NSString*) getScreenNameFromDictionary: (NSString*) theScreenName
{
    if([theScreenName compare:@""] == NSOrderedSame)
        return nil;
    return theScreenName;
}

-(UIColor*) getColorFromDictionary: (NSDictionary*) theDictionary
{
    int r = [(NSString*)[theDictionary objectForKey:@"red"] intValue];
    int g = [(NSString*)[theDictionary objectForKey:@"green"] intValue];
    int b = [(NSString*)[theDictionary objectForKey:@"blue"] intValue];
    int a = [(NSString*)[theDictionary objectForKey:@"alpha"] intValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

-(NSDictionary*) toDictionary
{
    return @{@"type": [self getModelTypeString:type],
             @"modelName": [self getModelName],
             @"color": [self getColorDictionary]};
}

-(NSString*) getModelTypeString: (enum modelType) modelType
{
    return [NSString stringWithFormat:@"%d", modelType];
}

-(NSString*) getModelName
{
    if (modelName == nil)
        return @"";
    return modelName;
}

-(NSDictionary*) getColorDictionary
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    if(color != nil) [color getRed:&red green:&green blue:&blue alpha: &alpha];
    return @{@"red": [NSString stringWithFormat: @"%d", (int)(255.0 * red)],
             @"green": [NSString stringWithFormat: @"%d", (int)(255.0 * green)],
             @"blue": [NSString stringWithFormat: @"%d", (int)(255.0 * blue)],
             @"alpha": [NSString stringWithFormat:@"%d", (int)(255.0 * alpha)]};
}

@end
