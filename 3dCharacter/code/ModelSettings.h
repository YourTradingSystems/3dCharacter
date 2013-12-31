//
//  ModelSettings.h
//  3dCharacter
//
//  Created by Vasya on 12/13/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <Foundation/Foundation.h>

enum modelType
{
    none,
    body,
    skin,
    hair,
    top,
    bottom,
    shoes,
    glasses
};

@interface ModelSettings : NSObject
{
    enum modelType type;
    NSString* modelName;
    UIColor* color;
}

@property (nonatomic) enum modelType type;
@property (nonatomic, retain) NSString* modelName;
@property (nonatomic, retain) UIColor* color;

- (id) initWithType: (enum modelType) theType andName: (NSString*) theName andColor:(UIColor*) theColor;
- (id) initWithDictionary: (NSDictionary*) theDictionary;
- (NSDictionary*) toDictionary;

- (NSString*) getModelTypeString: (enum modelType) modelType;
- (NSDictionary*) getColorDictionary;
- (NSString*) getModelName;

@end