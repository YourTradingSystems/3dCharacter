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
    BodyModelSettings* bmset = [[BodyModelSettings alloc] initWithType:body andName:@"female_model" andColor:nil];
    bmset.boneSizes = @{
        @"Bip002_Head" : [[Point3d alloc] initWithX:1 withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_Neck" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_R_UpperArm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_R_Forearm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_L_UpperArm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_L_Forearm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+y*-1/1000 withZ:1+z*-1/1000],
        @"Bip002_Spine2" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_Spine1" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_Spine" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_Pelvis" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_R_Thigh" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_R_Calf" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_L_Thigh" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
        @"Bip002_L_Calf" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y/1000) withZ:1+(z/1000)],
             //@"Bip002_" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             //@"Bip002_" : [[Point3d alloc] initWithX:x withY:y withZ:z],
             };
    return bmset;
}

- (NSDictionary*) initializeDictionary
{
    return @{@"cha1" : [self initializeBodySpines:-20 withY:60 withZ:60],
             @"cha2" : [self initializeBodySpines:-10 withY:40 withZ:40],
             @"cha3" : [self initializeBodySpines:0 withY:0 withZ:0],
             @"cha4" : [self initializeBodySpines:10 withY:40 withZ:40],
             @"cha5" : [self initializeBodySpines:20 withY:60 withZ:60],
             
             @"glasses1" : [[ModelSettings alloc] initWithType: glasses
                                                   andName:@"none"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses2" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses3" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses4" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses5" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses6" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses7" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses1"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses8" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses9" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses10" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses11" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses12" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             
             @"hairstyle1" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle2" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair2"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle3" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair3"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle4" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair4"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle5" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle6" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle7" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle8" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle9" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle10" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle11" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle12" : [[ModelSettings alloc] initWithType: hair
                                                         andName:@"hair1"
                                                        andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             
             @"shirt1" : [[ModelSettings alloc] initWithType: top
                                                          andName:@"shirt"
                                                         andColor: [UIColor colorWithRed:127.0/255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt2" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt"
                                                   andColor: [UIColor colorWithRed:38.0/255.0 green:127.0 / 25.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt3" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt"
                                                   andColor: [UIColor colorWithRed:0.0/255.0 green:148.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"shirt4" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt"
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:106.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt5" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt_middle"
                                                    andColor: [UIColor colorWithRed:127.0/255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt6" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt_middle"
                                                    andColor: [UIColor colorWithRed:38.0/255.0 green:127.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt7" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt_middle"
                                                    andColor: [UIColor colorWithRed:0.0/255.0 green:148.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"shirt8" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt_middle"
                                                    andColor: [UIColor colorWithRed:255.0/255.0 green:106.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"shirt9" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt"
                                                   andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt10" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt11" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt12" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             
             @"shoes1" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:213.0/255.0 green:189.0 / 255.0 blue:164.0 / 255.0 alpha:1.0]],
             @"shoes2" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:178.0/255.0 green:139.0 / 255.0 blue:104.0 / 255.0 alpha:1.0]],
             @"shoes3" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:209.0/255.0 green:137.0 / 255.0 blue:156.0 / 255.0 alpha:1.0]],
             @"shoes4" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:157.0/255.0 green:141.0 / 255.0 blue:110.0 / 255.0 alpha:1.0]],
             @"shoes5" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:86.0/255.0 green:64.0 / 255.0 blue:42.0 / 255.0 alpha:1.0]],
             @"shoes6" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:39.0/255.0 green:43.0 / 255.0 blue:19.0 / 255.0 alpha:1.0]],
             @"shoes7" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:211.0/255.0 green:186.0 / 255.0 blue:61.0 / 255.0 alpha:1.0]],
             @"shoes8" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:175.0/255.0 green:134.0 / 255.0 blue:100.0 / 255.0 alpha:1.0]],
             @"shoes9" : [[ModelSettings alloc] initWithType: shoes
                                                     andName:@"shoes1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes10" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes11" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes12" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             
             @"skin1" : [[ModelSettings alloc] initWithType: skin
                                                   andName:nil
                                                   andColor: [UIColor colorWithRed:252.0/255.0 green:239.0 / 255.0 blue:202.0 / 255.0 alpha:1.0]],
             @"skin2" : [[ModelSettings alloc] initWithType: skin
                                                    andName:nil
                                                   andColor: [UIColor colorWithRed:237.0/255.0 green:223.0 / 255.0 blue:220.0 / 255.0 alpha:1.0]],
             @"skin3" : [[ModelSettings alloc] initWithType: skin
                                                    andName:nil
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:206.0 / 255.0 blue:160.0 / 255.0 alpha:1.0]],
             @"skin4" : [[ModelSettings alloc] initWithType: skin
                                                    andName:nil
                                                    andColor: [UIColor colorWithRed:225.0/255.0 green:170.0 / 255.0 blue:149.0 / 255.0 alpha:1.0]],
             @"skin5" : [[ModelSettings alloc] initWithType: skin
                                                    andName:nil
                                                   andColor: [UIColor colorWithRed:144.0/255.0 green:97.0 / 255.0 blue:69.0 / 255.0 alpha:1.0]],
             @"skin6" : [[ModelSettings alloc] initWithType: skin
                                                    andName:nil
                                                   andColor: [UIColor colorWithRed:95.0/255.0 green:69.0 / 255.0 blue:53.0 / 255.0 alpha:1.0]],
             
             @"trousers1" : [[ModelSettings alloc] initWithType: bottom
                                                    andName:@"pants"
                                                      andColor: [UIColor colorWithRed:127.0/255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers2" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:38.0/255.0 green:127.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers3" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:0.0/255.0 green:148.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"trousers4" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:255.0/255.0 green:106.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers5" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"skirt_and_belt"
                                                       andColor: [UIColor colorWithRed:127.0/255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers6" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"skirt_and_belt"
                                                       andColor: [UIColor colorWithRed:38.0/255.0 green:127.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers7" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"skirt_and_belt"
                                                       andColor: [UIColor colorWithRed:0.0/255.0 green:148.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"trousers8" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"skirt_and_belt"
                                                       andColor: [UIColor colorWithRed:255.0/255.0 green:106.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"trousers9" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers10" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers11" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers12" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"pants"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]]};
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSObject*) getSettings: (NSString*) fileName
{
    NSLog(@"%@  -  %@", fileName, dicNameColor[fileName]);
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