//
//  AnimationPlayer.h
//  3DCharacter.temp_caseinsensitive_rename
//
//  Created by MacShit on 1/16/14.
//  Copyright (c) 2014 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3Scene.h"
#import "CC3Layer.h"
#import "CC3ActionInterval.h"

@interface AnimationPlayer : CC3Node
{
    int startFramesAnimation;
    int endFramesAnimation;
    int currentAnimation;
    NSMutableArray* animationArray;
    CC3Node* model;
    CCActionInterval *currentAction;
}

@property (nonatomic) int startFramesAnimation;
@property (nonatomic) int endFramesAnimation;
@property (nonatomic) int currentAnimation;
@property (nonatomic, retain) NSMutableArray* animationArray;
@property (nonatomic, retain) CC3Node* model;

- (id)initWithAnimatedModel:(CC3Node*)animatedModel  withKeyFrameStart:(int)startFrame andKeyFrameEnd:(int)endFrame;
- (void)playAnimation:(int)animationIndex;
- (int)getAnimCount;
- (int)getCurrentAnimationIndex;
- (void)playAnimations;
- (int)addNewAnimationWithTime:(int)fps startKeyFrame:(int)frameStart endKeyFrame:(int)frameEnd;
- (void)updateAnimation;
- (int)getRandomAnimationIndex;
- (CCAction*)getCurrentAnimationWithIndex:(int)index;

@end