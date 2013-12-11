//
//  CC3Manager.m
//  OBI
//
//  Created by OlegT on 9/10/13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//

#import "CCManager.h"
#import "CC3Resource.h"

#define kAnimationFrameRate	60.0f

@implementation CCManager

static CCManager *_sharedManager = nil;

+ (CCManager *)sharedManager {
	if (!_sharedManager) {
        _sharedManager = [[super alloc] init];
        
        [_sharedManager establishDirectorController];
	}
    
	return _sharedManager;
}

#pragma mark - Private Methods

- (void)establishDirectorController {
    
    if(![CCDirector setDirectorType: kCCDirectorTypeDisplayLink]) {
		[CCDirector setDirectorType: kCCDirectorTypeDefault];
    }
    
    // Create the view controller for the 3D view.
    _viewController = [CC3UIViewController new];
    _viewController.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    _viewController.viewShouldUseStencilBuffer = NO;
    _viewController.viewPixelSamples = 4;
        
    // Create the CCDirector, set the frame rate, and attach the view.
    CCDirector *director = CCDirector.sharedDirector;
    
    director.runLoopCommon = YES;		// Improves display link integration with UIKit
    director.animationInterval = (1.0f / kAnimationFrameRate);
    director.displayFPS = YES;
    director.openGLView = _viewController.view;
    
    // Enables High Res mode on Retina Displays and maintains low res on all other devices
    // This must be done after the GL view is assigned to the director!
    [director enableRetinaDisplay: YES];
}

#pragma mark - Public Methods

- (CC3GLView *)glView {
    if (!CCDirector.sharedDirector.view) {
        CCDirector.sharedDirector.openGLView = _viewController.view;
    }
    
    return _viewController.view;
}

- (void)clearCache {
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    [CC3Resource removeAllResources];
}

- (void)stop {
    [self runScene:[CCScene node]];
    [CCDirector.sharedDirector end];
}

- (void)pause {
    [CCDirector.sharedDirector pause];
    [CCDirector.sharedDirector stopAnimation];
}

- (void)resume {
    if (CCDirector.sharedDirector.isPaused) {
        [CCDirector.sharedDirector resume];
        [CCDirector.sharedDirector startAnimation];
    }
}

- (void)runScene:(CCScene *)scene {
    [CCDirector.sharedDirector stopAnimation];
    
    if (CCDirector.sharedDirector.runningScene) {
        [CCDirector.sharedDirector replaceScene:scene];
        [CCDirector.sharedDirector startAnimation];
    }
    else {
        [CCDirector.sharedDirector runWithScene:scene];
    }
}

- (void)removeAllSubViewsFromGLView {
    NSArray *views = [CCDirector.sharedDirector.openGLView subviews];
    
    for (id view in views) {
        [view removeFromSuperview];
    }
}

@end
