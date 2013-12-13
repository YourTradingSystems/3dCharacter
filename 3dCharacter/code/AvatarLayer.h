/**
 *  infedchaseLayer.h
 *  infedchase
 *
 *  Created by Srishti Innovative Systems on 06/07/13.
 *  Copyright SICS 2013. All rights reserved.
 */


#import "CC3Layer.h"
#import "AvatarModelSettings.h"


/** A sample application-specific CC3Layer subclass. */
@interface AvatarLayer : CC3Layer<UIScrollViewDelegate>
{    
    AvatarModelSettings *_avatarSettings;
}

@property (nonatomic, readonly) AvatarModelSettings *avatarSettings;

@end
