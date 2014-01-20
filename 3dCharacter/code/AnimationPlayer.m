//
//  AnimationPlayer.m
//  3DCharacter.temp_caseinsensitive_rename
//
//  Created by MacShit on 1/16/14.
//  Copyright (c) 2014 1. All rights reserved.
//

#import "AnimationPlayer.h"
#include "stdlib.h"
@implementation AnimationPlayer
@synthesize startFramesAnimation, endFramesAnimation, currentAnimation, animationArray, model;

-(id) initWithAnimatedModel:(CC3Node *)animatedModel withKeyFrameStart:(int)startFrame andKeyFrameEnd:(int)endFrame
{
    if (self = [super init])
    {
        //if ([animatedModel isAnimationEnabled] == YES)
        //{
        model = animatedModel;
        animationArray = [[NSMutableArray alloc] init];
        currentAnimation = -1;
        startFramesAnimation = startFrame;
        endFramesAnimation = endFrame;
        //}
        //else
            //[NSException raise:@"Model without animation" format:@"This model dont have the animation"];
    }
    return self;
}

-(void)playAnimation:(int)animationIndex
{
    currentAnimation = animationIndex;
}

-(int)getCurrentAnimationIndex
{
    return currentAnimation;
}

-(int)getAnimCount
{
    return animationArray.count;
}

-(int)addNewAnimationWithTime:(int)fps startKeyFrame:(int)frameStart endKeyFrame:(int)frameEnd
{
    currentAction = [CC3Animate actionWithDuration:(frameEnd - frameStart)/fps limitFrom:((float)frameStart/endFramesAnimation) to:((float)frameEnd/endFramesAnimation)];
    [animationArray addObject:currentAction];
    return animationArray.count;
}

-(int)getRandomAnimationIndex
{
    int randomIndexAnimation = 0;
    randomIndexAnimation = arc4random() % animationArray.count;
    while (true)
    {
        randomIndexAnimation = arc4random() % animationArray.count;
        if (currentAnimation != randomIndexAnimation)
            break;
    }
    return randomIndexAnimation;
}

-(CCAction*)getCurrentAnimationWithIndex:(int)index
{
    return [animationArray objectAtIndex:index];
}

-(void)playAnimations
{
    [self updateAnimation];
}

-(void) updateAnimation
{
    currentAnimation = [self getRandomAnimationIndex];
    CCCallFunc *updateFunc = [CCCallFunc actionWithTarget:self selector:@selector(updateAnimation)];
    CCSequence *loopAnimation = [CCSequence actions:[self getCurrentAnimationWithIndex:currentAnimation], updateFunc, nil];
    [model runAction:loopAnimation];
}
@end
