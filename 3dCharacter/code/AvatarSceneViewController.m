/**
 *  infedchaseScene.m
 *  infedchase
 *
 *  Created by Srishti Innovative Systems on 06/07/13.
 *  Copyright SICS 2013. All rights reserved.
 */

#import "AvatarSceneViewController.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3VertexSkinning.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "CC3ParametricMeshNodes.h"
#import "CC3UtilityMeshNodes.h"
#import "ModelSettings.h"
#import "CC3AffineMatrix.h"
#import "BodyModelSettings.h"
#import "Point3d.h"
#import "AnimationPlayer.h"

@implementation AvatarSceneViewController

-(void) dealloc {
	[super dealloc];
}

-(void) yawOnly {
    isArcBallRotationEnabled = NO;
    [self restoreCamAndMainNode];
}

-(void) initializeScene {
    
//    //Add backdrop begins
//    CC3PlaneNode * sprite = [CC3PlaneNode nodeWithName:@"spriteplane"];
//    [sprite populateAsCenteredRectangleWithSize:CGSizeMake(2*20.48, 2*15.36) andTessellation: CC3TessellationMake(5, 5)];
//    sprite.texture = [[CC3Texture textureFromFile: @"bgDrop.png"] retain];
//    sprite.location = CC3VectorMake(0, 0, -50);
//    [self addChild:sprite];
//    //Add backdrop ends

     self.backdrop = [CC3ClipSpaceNode nodeWithColor:kCCC4FWhite];
    
	// Create the camera, place it back a bit, and add it to the scene
	CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];

    cam.location = cc3v( 0.182793 , 3.147588, 13.966405); 

    cameraSavedLocation = cam.location;
    cameraSavedRotation = cam.quaternion;
	[self addChild: cam];
    
	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	lamp.location = cc3v( -2.0, 0.0, 0.0 );
	lamp.isDirectionalOnly = NO;
    lamp.opacity = 1.0;
	[cam addChild: lamp];
    
    [self setMainNode:@"male_model.pod"];
    
	[self createGLBuffers];
	[self releaseRedundantContent];
	[self selectShaderPrograms];

	LogInfo(@"The structure of this scene is: %@", [self structureDescription]);


    //Init for arcball rotation
    isArcBallRotationEnabled = YES;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    arcBallRadius = winSize.width / 3;
    arcBallRadiusSq = arcBallRadius * arcBallRadius;
    arcBallSafeRadius = arcBallRadius - 1;
    arcBallSafeRadiusSq = arcBallSafeRadius * arcBallSafeRadius;
    arcBallCenter = CGPointMake(winSize.width/2, winSize.height/2);
    
    [self yawOnly];
}

-(void) setMainNode: (NSString*) modelName
{
    [self removeChild:mainNode];
    [self addContentFromPODFile:modelName];
    mainNode = [self getNodeNamed: modelName];
    
    mainNode.shouldCullBackFaces = YES;
    //need this to do because we cant attach clothes to bones
    CC3Node *cylinder = [mainNode getNodeNamed:@"Cylinder005"];
    [cylinder remove];
    
    //adjust main node w.r.t backdrop
    [mainNode setScale:CC3VectorMake(0.5, 0.5, 0.51)];
    
    CC3Vector loc =  mainNode.location;
    loc.x -= 6;
    loc.y -= 1;
    loc.z -= 2;
    mainNode.location = loc;
    
    AnimationPlayer *player = [[AnimationPlayer alloc] initWithAnimatedModel:mainNode withKeyFrameStart:0 andKeyFrameEnd:889];
    [player addNewAnimationWithTime:30 startKeyFrame:0 endKeyFrame:535];
    [player addNewAnimationWithTime:30 startKeyFrame:535 endKeyFrame:719];
    [player addNewAnimationWithTime:30 startKeyFrame:719 endKeyFrame:889];
    [player playAnimations];

    //save restore point
    mainNodeSavedLocation = mainNode.location;
    mainNodeSavedRotation = mainNode.quaternion;
}

-(void) restoreCamAndMainNode {
    [self activeCamera].location = cameraSavedLocation;
    [self activeCamera].quaternion = cameraSavedRotation;
    mainNode.location = mainNodeSavedLocation;
    mainNode.quaternion = mainNodeSavedRotation;
}


-(void) enableChildOf:(CC3Node*) node AtIndex: (int) index
{
    int i=0;
    for (CC3Node* child in [node children]) {
        if (i==index) {
            [child show];
        } else {
            [child hide];
        }
        i++;
    }

}

#pragma mark Updating custom activity

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities before
 * any changes are applied to the transformMatrix of the 3D nodes in the scene.
 *
 * For more info, read the notes of this method on CC3Node.
 */

-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {
}



/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities after
 * the transformMatrix of the 3D nodes in the scen have been recalculated.
 *
 * For more info, read the notes of this method on CC3Node.
 */
-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {
	// If you have uncommented the moveWithDuration: invocation in the onOpen: method, you
	// can uncomment the following to track how the camera moves, where it ends up, and what
	// the camera's clipping distances are, in order to determine how to position and configure
	// the camera to view the entire scene.
//	LogDebug(@"Camera: %@", activeCamera.fullDescription);

   
}


#pragma mark Scene opening and closing

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene is first displayed.
 *
 * This method is a good place to invoke one of CC3Camera moveToShowAllOf:... family
 * of methods, used to cause the camera to automatically focus on and frame a particular
 * node, or the entire scene.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onOpen {

	// Move the camera to frame the scene. You can uncomment the LogDebug line in the
	// updateAfterTransform: method to track how the camera moves, where it ends up, and
	// what the camera's clipping distances are, in order to determine how to position
	// and configure the camera to view your entire scene. Then you can remove this code.
	//[self.activeCamera moveWithDuration: 3.0 toShowAllOf: self withPadding: 0.5f];

	// Uncomment this line to draw the bounding box of the scene.
	//self.shouldDrawWireframeBox = YES;
}

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene has been removed from display.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onClose {}


#pragma mark Handling touch events 



/**
 * This method is invoked from the CC3Layer whenever a touch event occurs, if that layer
 * has indicated that it is interested in receiving touch events, and is handling them.
 *
 * Override this method to handle touch events, or remove this method to make use of
 * the superclass behaviour of selecting 3D nodes on each touch-down event.
 *
 * This method is not invoked when gestures are used for user interaction. Your custom
 * CC3Layer processes gestures and invokes higher-level application-defined behaviour
 * on this customized CC3Scene subclass.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) touchEvent: (uint) touchType at: (CGPoint) touchPoint {
    CC3Vector arcBallCurrentTouchPoint;
	switch (touchType) {
		case kCCTouchBegan:
            if (isArcBallRotationEnabled) {
                arcBallStartTouchPoint = [self mapTouchPointToArcBall:touchPoint];
                lastTouchEventPoint = touchPoint;
            }else {
                lastTouchEventPoint = touchPoint;
            }
			break;

		case kCCTouchMoved:
            if (isArcBallRotationEnabled) {
//                touchPoint.y = lastTouchEventPoint.y;
                arcBallCurrentTouchPoint = [self mapTouchPointToArcBall:touchPoint];
                [self rotateObject: arcBallCurrentTouchPoint];
                arcBallStartTouchPoint = arcBallCurrentTouchPoint;
                lastTouchEventPoint = touchPoint;
            }else {
                [self rotateObjectAboutYAxis: touchPoint];
                lastTouchEventPoint = touchPoint;
            }
			break;
		case kCCTouchEnded:
			break;
		default:
			break;
	}
	
} 


-(CC3Vector) rotateDirectionByQuaternion: (CC3Vector) direction : (CC3Quaternion) quaternion {
    CC3Matrix3x3 rotationMatrix;
    CC3Matrix3x3PopulateFromQuaternion(&rotationMatrix, quaternion);
    CC3Vector rotatedDirection
     = CC3Matrix3x3TransformCC3Vector(&rotationMatrix, direction);
    return rotatedDirection;
}

#define kSwipeScale 0.6
-(void) rotateObjectAboutYAxis: (CGPoint) touchPoint {
    GLfloat angle = (touchPoint.x - lastTouchEventPoint.x) * kSwipeScale;
    CC3Vector4 axisaAngle = CC3Vector4Make(0, 1, 0, angle);
    CC3Quaternion rotation = CC3QuaternionFromAxisAngle(axisaAngle);
    [mainNode rotateByQuaternion:rotation];
}

-(CC3Vector) mapTouchPointToArcBall:(CGPoint) touchPoint {
    CGPoint p;
    p.x = touchPoint.x - arcBallCenter.x;
    p.y = touchPoint.y - arcBallCenter.y;
    p.y = -p.y;
    p.x = -p.x;
    CGFloat lengthSq = p.x * p.x + p.y * p.y;
    if (lengthSq > arcBallSafeRadiusSq) {
        CGFloat theta = atan2f(p.y, p.x);
        p.x = arcBallSafeRadius * cos(theta);
        p.y = arcBallSafeRadius * sin(theta);
        lengthSq = p.x * p.x + p.y * p.y;
    }
    CGFloat z = sqrtf(arcBallRadiusSq - lengthSq);
    CC3Vector mapped = CC3VectorMake(p.x, p.y, z);
    mapped = CC3VectorNormalize(mapped);
    return mapped;
}

-(CC3Quaternion) CreateQuatFromVectors: (CC3Vector) v0 : (CC3Vector) v1
{
    //cosine of the angle of rotation
    CGFloat d = CC3VectorDot(v0, v1);
    
    //two vectors are the same; do no rotation
    if (d > 0.9999999f) {
        return kCC3QuaternionIdentity;
    }
    
    //two vectors are 180 degrees apart; multiple number of axis of rotation; do a default rotation
    if ( d < -0.9999999f )
    {
        CC3Vector4 aa = CC3Vector4Make(1, 0, 0, 180);
        return CC3QuaternionFromAxisAngle(aa);
    }
    
    //rotation axis
    CC3Vector c = CC3VectorCross(v0, v1);
    
    //creating and normalizing quaternion formed by rotation axis
    //and angle of rotation with one call to sqrt() and no calls to acos()
    CGFloat s = sqrtf((1 + d) * 2);
    CGFloat invs = 1 / s;
    CC3Quaternion q;
    q.x = c.x * invs;
    q.y = c.y * invs;
    q.z = c.z * invs;
    q.w = s * 0.5f;
    return q;
}

-(void) rotateObject: (CC3Vector) arcBallTouchPoint
{    
    CC3Quaternion rotation;
    rotation =[self CreateQuatFromVectors:arcBallStartTouchPoint : arcBallTouchPoint];
    [mainNode rotateByQuaternion:rotation];
}

#undef kSwipeScale


/**
 * This callback template method is invoked automatically when a node has been picked
 * by the invocation of the pickNodeFromTapAt: or pickNodeFromTouchEvent:at: methods,
 * as a result of a touch event or tap gesture.
 *
 * Override this method to perform activities on 3D nodes that have been picked by the user.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) nodeSelected: (CC3Node*) aNode byTouchEvent: (uint) touchType at: (CGPoint) touchPoint {}

-(void) setAvatarSettings:(AvatarModelSettings *)theAvatarSettings
{
    [theAvatarSettings addObserver:self forKeyPath:@"skin" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"body" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"hair" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"top" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"bottom" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"shoes" options:NSKeyValueObservingOptionNew context: nil];
    [theAvatarSettings addObserver:self forKeyPath:@"glasses" options:NSKeyValueObservingOptionNew context: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onModelChanged:) name:@"modelChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onColorChanged:) name:@"colorChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBodyChanged:) name:@"bodyChanged" object:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath compare:@"body"] == NSOrderedSame) return;
    CC3Node *aModel = nil;
    UIColor *color = [UIColor alloc];
    ModelSettings *settings = (ModelSettings *)[change valueForKey:@"new"];
    NSString *namePODFile = settings.modelName;
    color = settings.color;
    
    if (namePODFile != nil)
    {
        namePODFile= [namePODFile stringByAppendingString:@".pod"];
        aModel = [self getNodeNamed:namePODFile];
        if (aModel == nil)
        {
            [self addContentFromPODFile:namePODFile];
            CC3Node *aModel = [self getNodeNamed:namePODFile];
            aModel.tag = settings.type;
            [self attachModel:aModel ToModel:mainNode withTag:settings.type];
            aModel.shouldCullBackFaces = NO;
            //aModel.shouldBlendAtFullOpacity = YES;
            //[aModel setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA}];
            //[aModel setOpacity:0];
        }
        aModel = [self getNodeNamed:namePODFile];
        [self changeColor:color ToModel:aModel];
    }
    else
        [self changeColor:color ToModel:mainNode];
}

-(void)attachModel:(CC3Node *)attachedModel ToModel:(CC3Node *)model withTag: (enum modelType) tag
{
    CC3Node *removedNode = nil;
    if ([model getNodeNamed:attachedModel.name] == nil)
    {
        for (CC3Node *node in model.children)
        {
            if (node.tag == tag)
                removedNode = node;
        }
        [removedNode remove];
        
        [model addChild:attachedModel];
        [attachedModel removeAnimationTrack:0];
        [attachedModel reattachBonesFrom:model];
        for (CC3Bone *softbone in attachedModel.children) {
            for (CC3Bone *skinMesh in softbone.children)
                for (CC3Bone *bone in skinMesh.children)
                    [softbone removeChild:bone];
        }
    }
}

-(void)changeColor:(UIColor *)color ToModel:(CC3Node *)model
{
    CC3Node *colorMaterial = [model getNodeNamed:@"planeColor"];
    if (colorMaterial != nil)
        colorMaterial.diffuseColor = color.asCCColor4F;
    else
        model.diffuseColor = color.asCCColor4F;
}

-(void) onModelChanged:(NSNotification *) notification
{
    
}

-(void) onColorChanged:(NSNotification *) notification
{
    
}

-(void) onBodyChanged:(NSNotification *) notification
{
    BodyModelSettings* bodySet = (BodyModelSettings*)[notification.userInfo objectForKey:@"body"];
    NSDictionary* spines = bodySet.boneSizes;
    for (NSString *boneName in spines) {
        CC3Bone* bone = (CC3Bone*)[mainNode getNodeNamed:boneName];
        [bone setScale: [(Point3d*)[spines objectForKey:boneName] getCC3Vector]];
    }
    [mainNode disableAllScaleAnimation];
}

@end