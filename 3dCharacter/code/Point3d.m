//
//  Point3d.m
//  3dCharacter
//
//  Created by Vasya on 12/26/13.
//  Copyright (c) 2013 1. All rights reserved.
//

#import "Point3d.h"

@implementation Point3d

@synthesize x=_x, y=_y, z=_z;

-(id) initWithX: (float) x withY: (float) y withZ: (float) z
{
    if(self =[super init])
    {
        _x = x;
        _y = y;
        _z = z;
    }
    return self;
}

-(CC3Vector) getCC3Vector
{
    return cc3v(self.x, self.y, self.z);
}

@end
