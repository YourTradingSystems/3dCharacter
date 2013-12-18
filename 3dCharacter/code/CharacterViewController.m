//
//  3DCharacterViewController.m
//  OBI
//
//  Created by Wu on 7/11/13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//

#import "CharacterViewController.h"
//#import "AppContainer.h"
//#import "OBIService.h"

//#import "ShareActivityRequest.h"
//#import "ActivityItem.h"
#import "CCManager.h"


#define kAnimationFrameRate		60		// Animation frame rate

@interface CharacterViewController ()

@end

@implementation CharacterViewController

//- (AppContainerMode)containerMode {
//    return AppContainerModeModality;
//}

//- (void)setActivity:(ActivityItem *)activity {
//    _activity = activity;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [CCManager.sharedManager resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) establishDirectorController {
//	
//	// Establish the type of CCDirector to use.
//	// Try to use CADisplayLink director and if it fails (SDK < 3.1) use the default director.
//	// This must be the first thing we do and must be done before establishing view controller.
//	if( ! [CCDirector setDirectorType: kCCDirectorTypeDisplayLink] )
//		[CCDirector setDirectorType: kCCDirectorTypeDefault];
//	
//	// Create the view controller for the 3D view.
//	_viewController = [CC3DeviceCameraOverlayUIViewController new];
//	_viewController.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
//	_viewController.viewShouldUseStencilBuffer = NO;		// Set to YES if using shadow volumes
//	_viewController.viewPixelSamples = 1;					// Set to 4 for antialiasing multisampling
//	
//	// Create the CCDirector, set the frame rate, and attach the view.
//	CCDirector *director = CCDirector.sharedDirector;
//	director.runLoopCommon = YES;		// Improves display link integration with UIKit
//	director.animationInterval = (1.0f / kAnimationFrameRate);
//	director.displayFPS = YES;
//	director.openGLView = _viewController.view;
//	
//	// Enables High Res mode on Retina Displays and maintains low res on all other devices
//	// This must be done after the GL view is assigned to the director!
//	[director enableRetinaDisplay: YES];
//}

//-(void) establishDirectorController {
//	_viewController = CC3DeviceCameraOverlayUIViewController.sharedDirector;
//	_viewController.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
//	_viewController.viewShouldUseStencilBuffer = NO;		// Set to YES if using shadow volumes
//	_viewController.viewPixelSamples = 1;					// Set to 4 for antialiasing multisampling
//	_viewController.animationInterval = (1.0f / kAnimationFrameRate);
//	_viewController.displayStats = YES;
//	[_viewController enableRetinaDisplay: YES];
//}

-(void) viewWillAppear:(BOOL)animated
{
    CCTexture2D.defaultAlphaPixelFormat = kCCTexture2DPixelFormat_RGBA8888;
	
	// Establish the view controller and CCDirector (in cocos2d 2.x, these are one and the same)
//	[self establishDirectorController];
    
	CC3Layer *cc3Layer = [AvatarLayer layerWithController:CCManager.sharedManager.viewController];
	
	// Create the customized 3D scene and attach it to the layer.
	// Could also just create this inside the customer layer.
	cc3Layer.cc3Scene = [AvatarSceneViewController scene];
	
	// Assign to a generic variable so we can uncomment options below to play with the capabilities
	CC3ControllableLayer* mainLayer = cc3Layer;
	
    cc3Layer.position = ccp(0.0, 250.0);
	// The 3D layer can run either directly in the scene, or it can run as a smaller "sub-window"
	// within any standard CCLayer. So you can have a mostly 2D window, with a smaller 3D window
	// embedded in it. To experiment with this smaller embedded 3D window, uncomment the following lines:
    //	CGSize winSize = CCDirector.sharedDirector.winSize;
    //	cc3Layer.position = ccp(30.0, 30.0);
    //	cc3Layer.contentSize = CGSizeMake(winSize.width - 100.0, winSize.width - 40.0);
    //	cc3Layer.alignContentSizeWithDeviceOrientation = YES;
    //	mainLayer = [CC3ControllableLayer node];
    //	[mainLayer addChild: cc3Layer];
	
	// A smaller 3D layer can even be moved around on the screen dyanmically. To see this in action,
	// uncomment the lines above as described, and also uncomment the following two lines.
    //	cc3Layer.position = ccp(0.0, 0.0);
    //	[cc3Layer runAction: [CCMoveTo actionWithDuration: 15.0 position: ccp(500.0, 250.0)]];
	
	// Attach the layer to the controller and run a scene with it.
    CCScene *scene = [CCScene node];
    [scene addChild:mainLayer];
    
	[[CCManager sharedManager] runScene:scene];
    UIView *openGlView = CCManager.sharedManager.glView;
    openGlView.frame = CGRectMake(0.f, 0.f, 1024.f, 1024.f);
    [self.view addSubview:openGlView];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [CCManager.sharedManager clearCache];
    [CCManager.sharedManager removeAllSubViewsFromGLView];
    [CCManager.sharedManager stop];
}

#pragma mark - ShareToolContent Protocol

//- (void)proceedShareActionWithRequest:(ShareActivityRequest *)request {
//    [[OBIService sharedService] shareActivityWithId:_activity.activityId
//                                            ToUsers:[request.selectedUsers valueForKey:@"userId"]
//                                        withMessage:request.message
//                                            handler:^(BOOL success, id object, NSData *responseData, NSError *error) {
//                                                NSString * shareMessage = (success) ? @"Activity shared successfully" : error.localizedDescription;
//                                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:(success) ? @"Sharing" : @"Error"
//                                                                                                message:shareMessage
//                                                                                               delegate:self
//                                                                                      cancelButtonTitle:@"ok"
//                                                                                      otherButtonTitles: nil];
//                                                [alert show];
//                                            }];
//}

- (NSArray*)shareOptions {
    return  @[@"Share Current Activity"];
}


-(NSString*)controllerGuidesName {
    return @"3D_Character_Maker";
}

@end
