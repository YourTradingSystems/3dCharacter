/**
 *  infedchaseScene.h
 *  infedchase
 *
 *  Created by Srishti Innovative Systems on 06/07/13.
 *  Copyright SICS 2013. All rights reserved.
 */


#import "CC3Scene.h"
#import "AvatarModelSettings.h"

/** A sample application-specific CC3Scene subclass.*/
@interface AvatarSceneViewController : CC3Scene {
    CGPoint    lastTouchEventPoint;
    CC3Node* mainNode;
    CC3Node* hatAttachment;
    CC3Node *pivot;
    CC3MeshNode* mainMesh;
    id texture1;
    id texture2;
    
    BOOL switchFlag;
    CGFloat timeElapsed;

    //Trackball
    BOOL isArcBallRotationEnabled;
    CGFloat arcBallRadius;
    CGFloat arcBallRadiusSq;
    CGFloat arcBallSafeRadius;
    CGFloat arcBallSafeRadiusSq;
    CGPoint arcBallCenter;
    CC3Vector arcBallStartTouchPoint;
    
    //Restore
    CC3Vector cameraSavedLocation;
    CC3Quaternion cameraSavedRotation;
    CC3Vector mainNodeSavedLocation;
    CC3Quaternion mainNodeSavedRotation;
}

-(void) yawOnly;
-(void) setAvatarSettings: (AvatarModelSettings*) theAvatarSettings;

//rotation about y
-(void) rotateObjectAboutYAxis: (CGPoint) touchPoint;

//arcball rotation
-(void) rotateObject: (CC3Vector) arcBallTouchPoint;
-(CC3Vector) mapTouchPointToArcBall:(CGPoint) touchPoint;

//util
-(void) restoreCamAndMainNode;
-(CCAction*) makePlayOnceActionFromFrameStart:(CGFloat) frameStart toFrameEnd:(CGFloat) frameEnd atFPS:(CGFloat)fps withTrackFrameCount:(CGFloat) frames;
-(CCAction*) makePlayLoopedActionFromFrameStart:(CGFloat) frameStart toFrameEnd:(CGFloat) frameEnd at:(CGFloat)fps withTrackFrameCount:(CGFloat) frames;
-(CCAction*) makePlayFirstFrameActionFromFrameStart:(CGFloat) frameStart withTrackFrameCount:(CGFloat) frames;

-(void) enableChildOf:(CC3Node*) node AtIndex: (int) index;
-(CC3Quaternion) CreateQuatFromVectors: (CC3Vector) v0 : (CC3Vector) v1;

-(void) setMainNode: (NSString*) modelName;

@end
