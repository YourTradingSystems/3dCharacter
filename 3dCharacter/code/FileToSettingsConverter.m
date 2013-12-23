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
    return @{@"cha1" : [[ModelSettings alloc] initWithType: body
                                                    andName:@"cha1"
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"cha2" : [[ModelSettings alloc] initWithType: body
                                                    andName:@"cha2"
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"cha3" : [[ModelSettings alloc] initWithType: body
                                                    andName:@"cha3"
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"cha4" : [[ModelSettings alloc] initWithType: body
                                                    andName:@"cha4"
                                                   andColor: [UIColor colorWithRed:255.0/255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             @"cha5" : [[ModelSettings alloc] initWithType: body
                                                    andName:@"cha5"
                                                  andColor: [UIColor colorWithRed:255.0/255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0]],
             
             @"glasses1" : [[ModelSettings alloc] initWithType: glasses
                                                   andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses2" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses3" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses4" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses5" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses6" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses7" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
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
             @"glasses13" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses14" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses15" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses16" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses17" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             @"glasses18" : [[ModelSettings alloc] initWithType: glasses
                                                       andName:@"glasses"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:50.0 / 255.0 blue:50.0 / 255.0 alpha:1.0]],
             
             @"hairstyle1" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle2" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle3" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
                                                       andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle4" : [[ModelSettings alloc] initWithType: hair
                                                        andName:@"hair1"
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
             @"hairstyle13" : [[ModelSettings alloc] initWithType: hair
                                                         andName:@"hair1"
                                                        andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle14" : [[ModelSettings alloc] initWithType: hair
                                                         andName:@"hair1"
                                                        andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle15" : [[ModelSettings alloc] initWithType: hair
                                                         andName:@"hair1"
                                                        andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             @"hairstyle16" : [[ModelSettings alloc] initWithType: hair
                                                         andName:@"hair1"
                                                         andColor: [UIColor colorWithRed:200.0/255.0 green:100.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]],
             
             @"shirt1" : [[ModelSettings alloc] initWithType: top
                                                          andName:@"shirt1"
                                                         andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt2" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt2"
                                                   andColor: [UIColor colorWithRed:210.0/255.0 green:10.0 / 25.0 blue:40.0 / 255.0 alpha:1.0]],
             @"shirt3" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt3"
                                                   andColor: [UIColor colorWithRed:250.0/255.0 green:10.0 / 255.0 blue:200.0 / 255.0 alpha:1.0]],
             @"shirt4" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt3"
                                                   andColor: [UIColor colorWithRed:230.0/255.0 green:100.0 / 255.0 blue:180.0 / 255.0 alpha:1.0]],
             @"shirt5" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:102.0/255.0 green:132.0 / 255.0 blue:132.0 / 255.0 alpha:1.0]],
             @"shirt6" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:120.0/255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0]],
             @"shirt7" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:231.0/255.0 green:231.0 / 255.0 blue:231.0 / 255.0 alpha:1.0]],
             @"shirt8" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:134.0/255.0 green:134.0 / 255.0 blue:134.0 / 255.0 alpha:1.0]],
             @"shirt9" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt3"
                                                   andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt10" : [[ModelSettings alloc] initWithType: top
                                                    andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt11" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt3"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt12" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt13" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt14" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt15" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt16" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt17" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
                                                    andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shirt18" : [[ModelSettings alloc] initWithType: top
                                                     andName:@"shirt1"
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
             @"shoes13" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes14" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes15" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes16" : [[ModelSettings alloc] initWithType: shoes
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes17" : [[ModelSettings alloc] initWithType: top
                                                      andName:@"shoes1"
                                                     andColor: [UIColor colorWithRed:20.0/255.0 green:100.0 / 255.0 blue:250.0 / 255.0 alpha:1.0]],
             @"shoes18" : [[ModelSettings alloc] initWithType: top
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
                                                    andName:@"trousers1"
                                                      andColor: [UIColor colorWithRed:86.0/255.0 green:64.0 / 255.0 blue:42.0 / 255.0 alpha:1.0]],
             @"trousers2" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers2"
                                                      andColor: [UIColor colorWithRed:86.0/255.0 green:64.0 / 255.0 blue:42.0 / 255.0 alpha:1.0]],
             @"trousers3" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers3"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:20.0 / 255.0 blue:20.0 / 255.0 alpha:1.0]],
             @"trousers4" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers4"
                                                      andColor: [UIColor colorWithRed:200.0/255.0 green:20.0 / 255.0 blue:20.0 / 255.0 alpha:1.0]],
             @"trousers5" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:42.0/255.0 green:35.0 / 255.0 blue:79.0 / 255.0 alpha:1.0]],
             @"trousers6" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:9.0/255.0 green:24.0 / 255.0 blue:90.0 / 255.0 alpha:1.0]],
             @"trousers7" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:164.0/255.0 green:164.0 / 255.0 blue:164.0 / 255.0 alpha:1.0]],
             @"trousers8" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:105.0/255.0 green:144.0 / 255.0 blue:144.0 / 255.0 alpha:1.0]],
             @"trousers9" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers1"
                                                      andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers10" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers1"
                                                      andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers11" : [[ModelSettings alloc] initWithType: bottom
                                                       andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers12" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers13" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers14" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers15" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers16" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers17" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]],
             @"trousers18" : [[ModelSettings alloc] initWithType: bottom
                                                        andName:@"trousers1"
                                                       andColor: [UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]]};
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (ModelSettings*) getSettings: (NSString*) fileName
{
    return (ModelSettings*)dicNameColor[fileName];
}

@end