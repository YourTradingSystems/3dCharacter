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
#define makeSettings(modelName, screenName, type, r, g, b) [[ModelSettings alloc]initWithType: type andModel: modelName ansScreen: screenName andColor: makeRgb(r, g, b)

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
        male = YES;
        maleSettings = [self initializeMaleDictionary];
        femaleSettings = [self initializeFemaleDictionary];
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

-(ModelSettings*) initializeBodySpines: (float) x withY: (float) y withZ: (float) z andScreen: (NSString*) screenName
{
    BodyModelSettings* bmset = [[BodyModelSettings alloc] initWithType:body  andModel:@"female_model" ansScreen:screenName andColor:nil];
    bmset.boneSizes = @{
        @"Bip002_Head" : [[Point3d alloc] initWithX:1 withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_Neck" : [[Point3d alloc] initWithX:1  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_R_UpperArm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_R_Forearm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_L_UpperArm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_L_Forearm" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_Spine2" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.3)/1000 withZ:1+(z*0.3)/1000],
        @"Bip002_Spine1" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*4)/1000 withZ:1+(z*4)/1000],
        @"Bip002_Spine" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*3)/1000 withZ:1+(y*3)/1000],
        @"Bip002_Pelvis" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.5)/1000 withZ:1+(z*0.5)/1000],
        @"Bip002_R_Thigh" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.3)/1000 withZ:1+(z*0.3)/1000],
        @"Bip002_R_Calf" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.3)/1000 withZ:1+(z*0.3)/1000],
        @"Bip002_L_Thigh" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.3)/1000 withZ:1+(z*0.3)/1000],
        @"Bip002_L_Calf" : [[Point3d alloc] initWithX:1+(x/1000)  withY:1+(y*0.3)/1000 withZ:1+(z*0.3)/1000],
             };
    return bmset;
}

- (NSDictionary*) initializeFemaleDictionary
{
    return @{@"cha1" : [self initializeBodySpines:-20 withY:40 withZ:60 andScreen:@"cha1"],
             @"cha2" : [self initializeBodySpines:-10 withY:20 withZ:40 andScreen:@"cha2"],
             @"cha3" : [self initializeBodySpines:0 withY:0 withZ:0 andScreen:@"cha3"],
             @"cha4" : [self initializeBodySpines:10 withY:20 withZ:40 andScreen:@"cha4"],
             @"cha5" : [self initializeBodySpines:20 withY:40 withZ:60 andScreen:@"cha5"],
             
             @"glasses1" : makeSettings(@"none", @"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses2" : makeSettings(@"glasses1", @"glasses2", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses3" : makeSettings(@"glasses1", @"glasses3", glasses, 255.0f, 0.0f, 0.0f),
             @"glasses4" : makeSettings(@"glasses1", @"glasses4", glasses, 255.0f, 255.0f, 255.0f),
             @"glasses5" : makeSettings(@"glasses1", @"glasses5", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses6" : makeSettings(@"glasses1", @"glasses6", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses7" : makeSettings(@"glasses1", @"glasses7", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses8" : makeSettings(@"glasses1", @"glasses8", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses9" : makeSettings(@"glasses1", @"glasses9", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses10" : makeSettings(@"glasses1", @"glasses10", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses11" : makeSettings(@"glasses1", @"glasses11", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses12" : makeSettings(@"glasses1", @"glasses12", glasses, 200.0f, 50.0f, 50.0f),
             
             @"hairstyle1" : makeSettings(@"hair1", @"hairstyle1", hair, 200.0f, 95.0f, 20.0f),
             @"hairstyle2" : makeSettings(@"hair2", @"hairstyle2", hair, 200.0f, 95.0f, 20.0f),
             @"hairstyle3" : makeSettings(@"hair3", @"hairstyle3", hair, 200.0f, 95.0f, 20.0f),
             @"hairstyle4" : makeSettings(@"hair4", @"hairstyle4", hair, 200.0f, 95.0f, 20.0f),
             @"hairstyle5" : makeSettings(@"hair1", @"hairstyle5", hair, 192.0f, 175.0f, 120.0f),
             @"hairstyle6" : makeSettings(@"hair2", @"hairstyle6", hair, 192.0f, 175.0f, 120.0f),
             @"hairstyle7" : makeSettings(@"hair3", @"hairstyle7", hair, 192.0f, 175.0f, 120.0f),
             @"hairstyle8" : makeSettings(@"hair4", @"hairstyle8", hair, 192.0f, 175.0f, 120.0f),
             @"hairstyle9" : makeSettings(@"hair1", @"hairstyle9", hair, 102.0f, 60.0f, 16.0f),
             @"hairstyle10" : makeSettings(@"hair2", @"hairstyle10", hair, 102.0f, 60.0f, 16.0f),
             @"hairstyle11" : makeSettings(@"hair3", @"hairstyle11", hair, 102.0f, 60.0f, 16.0f),
             @"hairstyle12" : makeSettings(@"hair4", @"hairstyle12", hair, 102.0f, 60.0f, 16.0f),
             
             @"shirt1" : makeSettings(@"shirt", @"shirt1", top, 190.0f, 160.0f, 160.0f),
             @"shirt2" : makeSettings(@"shirt", @"shirt2", top, 120.0f, 250.0f, 100.0f),
             @"shirt3" : makeSettings(@"shirt", @"shirt3", top, 160.0f, 130.0f, 200.0f),
             @"shirt4" : makeSettings(@"shirt", @"shirt4", top, 235.0f, 225.0f, 100.0f),
             
             @"shirt5" : makeSettings(@"shirt_short", @"shirt5", top, 220.0f, 140.0f, 180.0f),
             @"shirt6" : makeSettings(@"shirt_short", @"shirt6", top, 160.0f, 200.0f, 160.0f),
             @"shirt7" : makeSettings(@"shirt_short", @"shirt7", top, 180.0f, 180.0f, 180.0f),
             @"shirt8" : makeSettings(@"shirt_short", @"shirt8", top, 235.0f, 225.0f, 100.0f),
    
             @"shirt9" : makeSettings(@"shirt_middle", @"shirt9", top, 220.0f, 160.0f, 160.0f),
             @"shirt10": makeSettings(@"shirt_middle", @"shirt10", top, 120.0f, 200.0f, 100.0f),
             @"shirt11": makeSettings(@"shirt_middle", @"shirt11", top, 180.0f, 180.0f, 180.0f),
             @"shirt12": makeSettings(@"shirt_middle", @"shirt12", top, 130.0f, 120.0f, 100.0f),
             
             @"shirt13" : makeSettings(@"shirt_long", @"shirt13", top, 220.0f, 0.0f, 120.0f),
             @"shirt14" : makeSettings(@"shirt_long", @"shirt14", top, 00.0f, 180.0f, 0.0f),
             @"shirt15" : makeSettings(@"shirt_long", @"shirt15", top, 200.0f, 150.0f, 50.0f),
             @"shirt16" : makeSettings(@"shirt_long", @"shirt16", top, 250.0f, 70.0f, 40.0f),
             
             @"shoes1" : makeSettings(@"shoes1", @"shoes1", shoes, 213.0f, 189.0f, 164.0f),
             @"shoes2" : makeSettings(@"shoes1", @"shoes2", shoes, 178.0f, 139.0f, 104.0f),
             @"shoes3" : makeSettings(@"shoes1", @"shoes3", shoes, 209.0f, 137.0f, 156.0f),
             @"shoes4" : makeSettings(@"shoes1", @"shoes4", shoes, 157.0f, 141.0f, 110.0f),
             @"shoes5" : makeSettings(@"shoes1", @"shoes5", shoes, 86.0f, 64.0f, 42.0f),
             @"shoes6" : makeSettings(@"shoes1", @"shoes6", shoes, 39.0f, 43.0f, 19.0f),
             @"shoes7" : makeSettings(@"shoes1", @"shoes7", shoes, 211.0f, 186.0f, 61.0f),
             @"shoes8" : makeSettings(@"shoes1", @"shoes8", shoes, 175.0f, 134.0f, 100.0f),
             @"shoes9" : makeSettings(@"shoes1", @"shoes9", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes10" : makeSettings(@"shoes1", @"shoes10", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes11" : makeSettings(@"shoes1", @"shoes11", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes12" : makeSettings(@"shoes1", @"shoes12", shoes, 20.0f, 100.0f, 250.0f),
             
             @"skin1" : makeSettings(nil, @"skin1", skin, 252.0f, 239.0f, 202.0f),
             @"skin2" : makeSettings(nil, @"skin2", skin, 237.0f, 223.0f, 220.0f),
             @"skin3" : makeSettings(nil, @"skin3", skin, 255.0f, 206.0f, 160.0f),
             @"skin4" : makeSettings(nil, @"skin4", skin, 225.0f, 170.0f, 149.0f),
             @"skin5" : makeSettings(nil, @"skin5", skin, 144.0f, 97.0f, 69.0f),
             @"skin6" : makeSettings(nil, @"skin6", skin, 95.0f, 69.0f, 53.0f),
             
             @"trousers1" : makeSettings(@"pants", @"trousers1", bottom, 250.0f, 80.0f, 130.0f),
             @"trousers2" : makeSettings(@"pants", @"trousers2", bottom, 65.0f, 200.0f, 130.0f),
             @"trousers3" : makeSettings(@"pants", @"trousers3", bottom, 80.0f, 80.0f, 150.0f),
             @"trousers4" : makeSettings(@"pants", @"trousers4", bottom, 220.0f, 220.0f, 0.0f),
             @"trousers5" : makeSettings(@"skirt_and_belt", @"trousers5", bottom, 250.0f, 80.0f, 130.0f),
             @"trousers6" : makeSettings(@"skirt_and_belt", @"trousers6", bottom, 65.0f, 180.0f, 110.0f),
             @"trousers7" : makeSettings(@"skirt_and_belt", @"trousers7", bottom, 80.0f, 80.0f, 130.0f),
             @"trousers8" : makeSettings(@"skirt_and_belt", @"trousers8", bottom, 160.0f, 70.0f, 40.0f),
             @"trousers9" : makeSettings(@"skirt", @"trousers9", bottom, 180.0f, 80.0f, 40.0f),
             @"trousers10" : makeSettings(@"skirt", @"trousers10", bottom, 65.0f, 200.0f, 100.0f),
             @"trousers11" : makeSettings(@"skirt", @"trousers11", bottom, 100.0f, 100.0f, 130.0f),
             @"trousers12" : makeSettings(@"skirt", @"trousers12", bottom, 250.0f, 220.0f, 0.0f)};
}

- (NSDictionary*) initializeMaleDictionary
{
    return @{@"cha1" : [self initializeBodySpines:-20 withY:40 withZ:60 andScreen:@"cha1"],
             @"cha2" : [self initializeBodySpines:-10 withY:20 withZ:40 andScreen:@"cha2"],
             @"cha3" : [self initializeBodySpines:0 withY:0 withZ:0 andScreen:@"cha3"],
             @"cha4" : [self initializeBodySpines:10 withY:20 withZ:40 andScreen:@"cha4"],
             @"cha5" : [self initializeBodySpines:20 withY:40 withZ:60 andScreen:@"cha5"],
             
             @"glasses1" : makeSettings(@"none", @"glasses1", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses2" : makeSettings(@"glasses1_male", @"glasses2", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses3" : makeSettings(@"glasses1_male", @"glasses3", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses4" : makeSettings(@"glasses1_male", @"glasses4", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses5" : makeSettings(@"glasses1_male", @"glasses5", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses6" : makeSettings(@"glasses1_male", @"glasses6", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses7" : makeSettings(@"glasses1_male", @"glasses7", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses8" : makeSettings(@"glasses1_male", @"glasses8", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses9" : makeSettings(@"glasses1_male", @"glasses9", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses10" : makeSettings(@"glasses1_male", @"glasses10", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses11" : makeSettings(@"glasses1_male", @"glasses11", glasses, 200.0f, 50.0f, 50.0f),
             @"glasses12" : makeSettings(@"glasses1_male", @"glasses12", glasses, 200.0f, 50.0f, 50.0f),
             
             @"hairstyle1" : makeSettings(@"hair1_male", @"hairstyle1_male", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle2" : makeSettings(@"hair1_male", @"hairstyle2_male", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle3" : makeSettings(@"hair1_male", @"hairstyle3_male", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle4" : makeSettings(@"hair1_male", @"hairstyle4_male", hair, 200.0f, 100.0f, 0.0f),
             @"hairstyle5" : makeSettings(@"hair1_male", @"hairstyle5_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle6" : makeSettings(@"hair1_male", @"hairstyle6_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle7" : makeSettings(@"hair1_male", @"hairstyle7_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle8" : makeSettings(@"hair1_male", @"hairstyle8_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle9" : makeSettings(@"hair1_male", @"hairstyle9_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle10" : makeSettings(@"hair1_male", @"hairstyle10_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle11" : makeSettings(@"hair1_male", @"hairstyle11_male", hair, 200.0f, 50.0f, 0.0f),
             @"hairstyle12" : makeSettings(@"hair1_male", @"hairstyle12_male", hair, 200.0f, 50.0f, 0.0f),
             
             @"shirt1" : makeSettings(@"shirt_long_male", @"shirt1_male", top, 127.0f, 0.0f, 0.0f),
             @"shirt2" : makeSettings(@"shirt_long_male", @"shirt2_male", top, 38.0f, 127.0f, 0.0f),
             @"shirt3" : makeSettings(@"shirt_long_male", @"shirt3_male", top, 0.0f, 148.0f, 255.0f),
             @"shirt4" : makeSettings(@"shirt_long_male", @"shirt4_male", top, 255.0f, 106.0f, 0.0f),
             @"shirt5" : makeSettings(@"shirt_long2_male", @"shirt5_male", top, 127.0f, 0.0f, 0.0f),
             @"shirt6" : makeSettings(@"shirt_long2_male", @"shirt6_male", top, 38.0f, 127.0f, 0.0f),
             @"shirt7" : makeSettings(@"shirt_long2_male", @"shirt7_male", top, 0.0f, 148.0f, 255.0f),
             @"shirt8" : makeSettings(@"shirt_long2_male", @"shirt8_male", top, 157.0f, 141.0f, 110.0f),
             @"shirt9" : makeSettings(@"shirt_long_male", @"shirt9_male", top, 127.0f, 0.0f, 0.0f),
             @"shirt10" : makeSettings(@"shirt_long_male", @"shirt10_male", top, 0.0f, 157.0f, 0.0f),
             @"shirt11" : makeSettings(@"shirt_long_male", @"shirt11_male", top, 86.0f, 64.0f, 42.0f),
             @"shirt12" : makeSettings(@"shirt_long_male", @"shirt12_male", top, 255.0f, 105.0f, 0.0f),
             
             @"shoes1" : makeSettings(@"shoes1_male", @"shoes1", shoes, 213.0f, 189.0f, 164.0f),
             @"shoes2" : makeSettings(@"shoes1_male", @"shoes2", shoes, 178.0f, 139.0f, 104.0f),
             @"shoes3" : makeSettings(@"shoes1_male", @"shoes3", shoes, 209.0f, 137.0f, 156.0f),
             @"shoes4" : makeSettings(@"shoes1_male", @"shoes4", shoes, 157.0f, 141.0f, 110.0f),
             @"shoes5" : makeSettings(@"shoes1_male", @"shoes5", shoes, 86.0f, 64.0f, 42.0f),
             @"shoes6" : makeSettings(@"shoes1_male", @"shoes6", shoes, 39.0f, 43.0f, 19.0f),
             @"shoes7" : makeSettings(@"shoes1_male", @"shoes7", shoes, 211.0f, 186.0f, 61.0f),
             @"shoes8" : makeSettings(@"shoes1_male", @"shoes8", shoes, 175.0f, 134.0f, 100.0f),
             @"shoes9" : makeSettings(@"shoes1_male", @"shoes9", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes10" : makeSettings(@"shoes1_male", @"shoes10", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes11" : makeSettings(@"shoes1_male", @"shoes11", shoes, 20.0f, 100.0f, 250.0f),
             @"shoes12" : makeSettings(@"shoes1_male", @"shoes12", shoes, 20.0f, 100.0f, 250.0f),
             
             @"skin1" : makeSettings(nil, @"skin1", skin, 252.0f, 239.0f, 202.0f),
             @"skin2" : makeSettings(nil, @"skin2", skin, 237.0f, 223.0f, 220.0f),
             @"skin3" : makeSettings(nil, @"skin3", skin, 255.0f, 206.0f, 160.0f),
             @"skin4" : makeSettings(nil, @"skin4", skin, 225.0f, 170.0f, 149.0f),
             @"skin5" : makeSettings(nil, @"skin5", skin, 144.0f, 97.0f, 69.0f),
             @"skin6" : makeSettings(nil, @"skin6", skin, 95.0f, 69.0f, 53.0f),
             
             @"trousers1" : makeSettings(@"shorts1_male", @"trousers1_male", bottom, 127.0f, 0.0f, 0.0f),
             @"trousers2" : makeSettings(@"shorts1_male", @"trousers2_male", bottom, 38.0f, 127.0f, 0.0f),
             @"trousers3" : makeSettings(@"shorts1_male", @"trousers3_male", bottom, 0.0f, 148.0f, 255.0f),
             @"trousers4" : makeSettings(@"shorts1_male", @"trousers4_male", bottom, 255.0f, 106.0f, 0.0f),
             @"trousers5" : makeSettings(@"shorts1_male", @"trousers5_male", bottom, 127.0f, 0.0f, 0.0f),
             @"trousers6" : makeSettings(@"shorts1_male", @"trousers6_male", bottom, 38.0f, 127.0f, 0.0f),
             @"trousers7" : makeSettings(@"shorts1_male", @"trousers7_male", bottom, 0.0f, 148.0f, 255.0f),
             @"trousers8" : makeSettings(@"shorts1_male", @"trousers8_male", bottom, 255.0f, 106.0f, 0.0f),
             @"trousers9" : makeSettings(@"shorts1_male", @"trousers9_male", bottom, 127.0f, 0.0f, 0.0f),
             @"trousers10" : makeSettings(@"shorts1_male", @"trousers10_male", bottom, 38.0f, 127.0f, 0.0f),
             @"trousers11" : makeSettings(@"shorts1_male", @"trousers11_male", bottom, 0.0f, 148.0f, 255.0f),
             @"trousers12" : makeSettings(@"shorts1_male", @"trousers12_male", bottom, 255.0f, 106.0f, 0.0f)};
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSObject*) getSettings: (NSString*) setName
{
    if (male)
        return maleSettings[setName];
    else
        return femaleSettings[setName];
}

-(NSArray*) getTypeSettings: (enum modelType) type
{
    NSMutableArray* sets = [[NSMutableArray alloc] init];    
    NSDictionary* dictionary = [self getSetsDictionary];

    for (NSString* key in dictionary) {
        ModelSettings* settings = [dictionary objectForKey:key];
        if(settings.type == type)
            [sets addObject:settings];
    }
    return sets;
}

-(NSDictionary*) getSetsDictionary
{
    if (male)
        return maleSettings;
    return femaleSettings;
}

-(void) setMale:(BOOL)value
{
    male = value;
}

- (void) saveToJson
{
    NSDictionary* dicToJson = [self getSetsDictionary];
    NSMutableDictionary* dicForJson = [self getDictionaryForJson: dicToJson];
    
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
        ModelSettings* settings = [theDictionary objectForKey:key];
        [dictionaryForJson setObject:[settings toDictionary] forKey:key];
    }
    return dictionaryForJson;
}

@end