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
        [self saveToJson];
    }
    return self;
}

-(NSDictionary*) initializeBodySpines: (float) x withY: (float) y withZ: (float) z
{
    return @{@"Spine2.002" : [[Point3d alloc] initWithX:x withY:y withZ:z],
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
}

- (NSDictionary*) initializeDictionary
{
    return @{@"cha1" : [self initializeBodySpines:1.4 withY:0.8 withZ:1.4],
             @"cha2" : [self initializeBodySpines:1.2 withY:0.9 withZ:1.2],
             @"cha3" : [self initializeBodySpines:1 withY:1 withZ:1],
             @"cha4" : [self initializeBodySpines:1.2 withY:1.1 withZ:1.2],
             @"cha5" : [self initializeBodySpines:1.4 withY:1.2 withZ:1.4],
             
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
                                                          andName:@"t-shirt"
                                                         andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt2" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt2"
                                                   andColor: [UIColor colorWithRed:210.0/255.0 green:10.0 / 255.0 blue:40.0 / 255.0 alpha:1.0]],
             @"shirt3" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"t-shirt_long"
                                                   andColor: [UIColor colorWithRed:250.0/255.0 green:10.0 / 255.0 blue:200.0 / 255.0 alpha:1.0]],
             @"shirt4" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"t-shirt"
                                                   andColor: [UIColor colorWithRed:230.0/255.0 green:100.0 / 255.0 blue:180.0 / 255.0 alpha:1.0]],
             @"shirt5" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:102.0/255.0 green:132.0 / 255.0 blue:132.0 / 255.0 alpha:1.0]],
             @"shirt6" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:120.0/255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0]],
             @"shirt7" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:231.0/255.0 green:231.0 / 255.0 blue:231.0 / 255.0 alpha:1.0]],
             @"shirt8" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:134.0/255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0]],
             @"shirt9" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"t-shirt"
                                                   andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt10" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt11" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt12" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"t-shirt"
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
                                                      andColor: [UIColor colorWithRed: 80.0/255.0 green: 80.0 / 255.0 blue:200.0 / 255.0 alpha:1.0]],
             @"trousers2" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"pants"
                                                      andColor: [UIColor colorWithRed:160.0/255.0 green:10.0 / 255.0 blue:107.0 / 255.0 alpha:1.0]],
             @"trousers3" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"skirt"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:20.0 / 255.0 blue:20.0 / 255.0 alpha:1.0]],
             @"trousers4" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"skirt_and_belt"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:20.0 / 255.0 blue:20.0 / 255.0 alpha:1.0]],
             @"trousers5" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"pants"
                                                       andColor: [UIColor colorWithRed:42.0/255.0 green:35.0 / 255.0 blue:79.0 / 255.0 alpha:1.0]],
             @"trousers6" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"pants"
                                                       andColor: [UIColor colorWithRed:9.0/255.0 green:24.0 / 255.0 blue:90.0 / 255.0 alpha:1.0]],
             @"trousers7" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"pants"
                                                       andColor: [UIColor colorWithRed:164.0/255.0 green:164.0 / 255.0 blue:164.0 / 255.0 alpha:1.0]],
             @"trousers8" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"pants"
                                                       andColor: [UIColor colorWithRed:105.0/255.0 green:144.0 / 255.0 blue:144.0 / 255.0 alpha:1.0]],
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
    return dicNameColor[fileName];
}

- (void) saveToJson
{
    NSMutableDictionary* dicForJson = [self getDictionaryForJson: dicNameColor];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicForJson options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
}

- (NSMutableDictionary*) getDictionaryForJson: (NSDictionary*) theDictionary
{
    NSMutableDictionary* dictionaryForJson = [[NSMutableDictionary alloc] init];
    for (NSString* key in theDictionary) {
        ModelSettings* settings = [theDictionary objectForKey:key];
        [dictionaryForJson setObject:settings.toDictionary forKey:key];
    }
    return dictionaryForJson;
}

@end