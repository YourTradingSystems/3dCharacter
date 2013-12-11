//
//  CC3Manager.h
//  OBI
//
//  Created by OlegT on 9/10/13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//

#import "CC3UIViewController.h"

@interface CCManager : NSObject

@property (nonatomic, retain, readonly) CC3UIViewController *viewController;

+ (CCManager *)sharedManager;

- (CC3GLView *)glView;
- (void)clearCache;

- (void)stop;
- (void)pause;
- (void)resume;

- (void)runScene:(CCScene *)scene;

- (void)removeAllSubViewsFromGLView;

@end
