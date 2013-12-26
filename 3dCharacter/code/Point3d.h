//
//  Point3d.h
//  3dCharacter
//
//  Created by Vasya on 12/26/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3Foundation.h"

@interface Point3d : NSObject
{
    @protected float _x,_y,_z;
}

@property (nonatomic, readonly) float x;
@property (nonatomic, readonly) float y;
@property (nonatomic, readonly) float z;

-(id) initWithX: (float) x withY: (float) y withZ: (float) z;
-(CC3Vector) getCC3Vector;

@end
