//
//  FileToSettingsConverter.m
//  3dCharacter
//
//  Created by Vasya on 12/12/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "FileToSettingsConverter.h"
#import "ModelSettings.h"
#import "Point3d.h"
#import "BodyModelSettings.h"

#define makeRgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0]]
#define makeSettings(name, type, r,g,b) [[ModelSettings alloc] initWithType: type andName:name andColor: makeRgb(r, g, b)

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
        //[self saveToJson];
    }
    return self;
}

-(NSDictionary*) initializeDictionaryFromJson
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"settings"];
    
    NSData* jsonData = [NSData dataWithContentsOfFile:docFile];
    
    NSError* error;
    NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    return [self parseDictionaryToModels: parsedData];
}

- (NSDictionary*) parseDictionaryToModels: (NSDictionary*) theDictionary
{
    NSMutableDictionary* resultDict = [[NSMutableDictionary alloc] init];
    for (NSString* key in theDictionary) {
        NSDictionary* setDict = (NSDictionary*)[theDictionary objectForKey:key];
        ModelSettings* settings = [self getSettingsFromDictionary: setDict];
       
        [resultDict setObject:settings forKey:key];
    }
    return resultDict;
}

-(ModelSettings*) getSettingsFromDictionary: (NSDictionary*) setDictionary
{
    ModelSettings* settings;
    @try
    {
        settings = [[BodyModelSettings alloc] initWithDictionary:setDictionary];
    }
    @catch (NSException *exception)
    {
        settings = [[ModelSettings alloc] initWithDictionary:setDictionary];
    }
    return settings;
}

-(ModelSettings*) initializeBodySpines: (float) x withY: (float) y withZ: (float) z
{
    BodyModelSettings* bmset = [[BodyModelSettings alloc] initWithType:body andName:@"final_female" andColor:nil];
    bmset.boneSizes = @{@"Spine2.002" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"Spine2.001" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightForeArm" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightArm" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftForeArm" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftArm" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"Spine2" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"Spine1" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightUpLeg" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightLeg" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightFoot" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"RightToeBase" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftUpLeg" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftLeg" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftFoot" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             @"LeftToeBase" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             };
    return bmset;
}

- (NSDictionary*) initializeDictionary
{
    return @{@"cha1" : [self initializeBodySpines:1.4 withY:0.8 withZ:1.4],
             @"cha2" : [self initializeBodySpines:1.2 withY:0.9 withZ:1.2],
             @"cha3" : [self initializeBodySpines:1 withY:1 withZ:1],
             @"cha4" : [self initializeBodySpines:1.2 withY:1.1 withZ:1.2],
             @"cha5" : [self initializeBodySpines:1.4 withY:1.2 withZ:1.4],
             
             @"glasses1" : makeSettings(@"none", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses2" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses3" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses4" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses5" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses6" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses7" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses8" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses9" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses10" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses11" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses12" : makeSettings(@"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             
             @"hairstyle1" : makeSettings(@"hair1", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle2" : makeSettings(@"hair2", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle3" : makeSettings(@"hair3", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle4" : makeSettings(@"hair4", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle5" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle6" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle7" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle8" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle9" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle10" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle11" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle12" : makeSettings(@"hair1", hair, 200.0f, 50.0f, 0.0f),
             
             @"shirt1" : makeSettings(@"shirt", top, 127.0f, 0.0f, 0.0f),
             @"shirt2" : makeSettings(@"shirt", top, 38.0f, 127.0f, 0.0f),
             @"shirt3" : makeSettings(@"shirt", top, 0.0f, 148.0f, 255.0f),
             @"shirt4" : makeSettings(@"shirt", top, 255.0f, 106.0f, 0.0f),
             @"shirt5" : makeSettings(@"shirt_middle", top, 127.0f, 0.0f, 0.0f),
             @"shirt6" : makeSettings(@"shirt_middle", top, 38.0f, 127.0f, 0.0f),
             @"shirt7" : makeSettings(@"shirt_middle", top, 0.0f, 148.0f, 255.0f),
             @"shirt8" : makeSettings(@"shirt_middle", top, 255.0f, 105.0f, 0.0f),
             @"shirt9" : makeSettings(@"shirt", top, 20.0f, 100.0f, 250.0f),
             @"shirt10" : makeSettings(@"shirt", top, 20.0f, 100.0f, 250.0f),
             @"shirt11" : makeSettings(@"shirt", top, 20.0f, 100.0f, 250.0f),
             @"shirt12" : makeSettings(@"shirt", top, 20.0f, 100.0f, 250.0f),
             
             @"shoes1" : makeSettings(@"shoes1", shoes, 213.0f, 189.0f, 164.0f),
             @"shoes2" : makeSettings(@"shoes1", shoes, 178.0f, 139.0f, 104.0f),
             @"shoes3" : makeSettings(@"shoes1", shoes, 209.0f, 137.0f, 156.0f),
             @"shoes4" : makeSettings(@"shoes1", shoes, 157.0f, 141.0f, 110.0f),
             @"shoes5" : makeSettings(@"shoes1", shoes, 86.0f, 64.0f, 42.0f),
             @"shoes6" : makeSettings(@"shoes1", shoes, 39.0f, 43.0f, 19.0f),
             @"shoes7" : makeSettings(@"shoes1", shoes, 211.0f, 186.0f, 61.0f),
             @"shoes8" : makeSettings(@"shoes1", shoes, 175.0f, 134.0f, 100.0f),
             @"shoes9" : makeSettings(@"shoes1", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes10" : makeSettings(@"shoes1", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes11" : makeSettings(@"shoes1", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes12" : makeSettings(@"shoes1", shoes, 20.0f, 100.0f, 250.0f),
             
             @"skin1" : makeSettings(nil, skin, 252.0f, 239.0f, 202.0f),
             @"skin2" : makeSettings(nil, skin, 237.0f, 223.0f, 220.0f),
             @"skin3" : makeSettings(nil, skin, 255.0f, 206.0f, 160.0f),
             @"skin4" : makeSettings(nil, skin, 225.0f, 170.0f, 149.0f),
             @"skin5" : makeSettings(nil, skin, 144.0f, 97.0f, 69.0f),
             @"skin6" : makeSettings(nil, skin, 95.0f, 69.0f, 53.0f),
             
             @"trousers1" : makeSettings(@"pants", bottom, 127.0f, 0.0f, 0.0f),
             @"trousers2" : makeSettings(@"pants", bottom, 38.0f, 127.0f, 0.0f),
             @"trousers3" : makeSettings(@"pants", bottom, 0.0f, 148.0f, 255.0f),
             @"trousers4" : makeSettings(@"pants", bottom, 255.0f, 106.0f, 0.0f),
             @"trousers5" : makeSettings(@"skirt_and_belt", bottom, 127.0f, 0.0f, 0.0f),
             @"trousers6" : makeSettings(@"skirt_and_belt", bottom, 38.0f, 127.0f, 0.0f),
             @"trousers7" : makeSettings(@"skirt_and_belt", bottom, 0.0f, 148.0f, 255.0f),
             @"trousers8" : makeSettings(@"skirt_and_belt", bottom, 255.0f, 106.0f, 0.0f),
             @"trousers9" : makeSettings(@"pants", bottom, 247.0f, 247.0f, 247.0f),
             @"trousers10" : makeSettings(@"pants", bottom, 247.0f, 247.0f, 247.0f),
             @"trousers11" : makeSettings(@"pants", bottom, 247.0f, 247.0f, 247.0f),
             @"trousers12" : makeSettings(@"pants", bottom, 247.0f, 247.0f, 247.0f)};
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSObject*) getSettings: (NSString*) fileName
{
    return dicNameColor[fileName];
}

- (void) saveToJson
{
    NSMutableDictionary* dicForJson = [self getDictionaryForJson: dicNameColor];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicForJson options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"settings"];
    
    NSError* error;
    [jsonString writeToFile:docFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

- (NSMutableDictionary*) getDictionaryForJson: (NSDictionary*) theDictionary
{
    NSMutableDictionary* dictionaryForJson = [[NSMutableDictionary alloc] init];
    for (NSString* key in theDictionary) {
        NSLog(@"model name:  %@", key);
        ModelSettings* settings = [theDictionary objectForKey:key];
        [dictionaryForJson setObject:[settings toDictionary] forKey:key];
    }
    return dictionaryForJson;
}

@end