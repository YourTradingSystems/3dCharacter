/**
 *  infedchaseLayer.m
 *  infedchase
 *
 *  Created by Srishti Innovative Systems on 06/07/13.
 *  Copyright SICS 2013. All rights reserved.
 */

#import "AvatarLayer.h"
#import "AvatarSceneViewController.h"
#import "AvatarConstants.h"
#import "AvatarModelSettings.h"
#import "FileToSettingsConverter.h"
//#import "AppContainer.h"

@interface CC3Layer(Private)

-(BOOL) handleTouch: (UITouch*) touch ofType: (uint) touchType;


@end

@implementation AvatarLayer

@synthesize avatarSettings = _avatarSettings;

-(void) dealloc {
    [super dealloc];
}

/**
 * Override to set up your 2D controls and other initial state, and to initialize update processing.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) initializeControls {
	[self scheduleUpdate];
    self.isTouchEnabled = YES;
    _avatarSettings = [[AvatarModelSettings alloc] init];
    
    [self setContentSize:CGSizeMake(1024,768)];

    [self yawOnly];
    
    [self playAnimModeOnce];    
}
    
     
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}


#pragma mark Updating layer

/**
 * Override to perform set-up activity prior to the scene being opened
 * on the view, such as adding gesture recognizers.
 *
 * For more info, read the notes of this method on CC3Layer.
 */

//-(void) arbitory {
//    [[self cc3Scene] arbitory];
//}
//
//
-(void) yawOnly {
    [(AvatarSceneViewController*)[self cc3Scene] yawOnly];
}
//
//-(void) resetRot {
//    [[self cc3Scene] resetRot];
//}
//
//
-(void) playAnim {
    id aClass = self.cc3Scene;
    NSLog(@"cc3Scene.class = %@", [aClass class]);
    
    if (![aClass respondsToSelector:@selector(playAnim)]) {
        NSLog(@"%@ not contain selector playAnim", [aClass class]);
    }
    
    [(AvatarSceneViewController*)[self cc3Scene] playAnim];
}
//
//-(void) stopAnimations {
//    [[self cc3Scene] stopAnimations];
//}
//
//-(void) playAnimModeLooped {
//    [[self cc3Scene] playAnimModeLooped];
//}
//
-(void) playAnimModeOnce {
    [(AvatarSceneViewController*)[self cc3Scene] playAnimModeOnce];
}




-(void) onOpenCC3Layer {

//    CCMenuItemFont *resetRot =
//    [CCMenuItemFont itemFromString:@"Reset" target:self selector:@selector(resetRot)];
//  
//    CCMenuItemFont *yawOnly =
//    [CCMenuItemFont itemFromString:@"YawOnly" target:self selector:@selector(yawOnly)];
//    
//    CCMenuItemFont *arcBall =
//    [CCMenuItemFont itemFromString:@"Arbitory" target:self selector:@selector(arbitory)];
//
//    CCMenuItemFont *playLooped =
//    [CCMenuItemFont itemFromString:@"LoopAnims" target:self selector:@selector(playAnimModeLooped)];
//
//    CCMenuItemFont *playOnce =
//    [CCMenuItemFont itemFromString:@"Don'tLoopAnims" target:self selector:@selector(playAnimModeOnce)];
//
//    
//    CCMenuItemFont *play =
//    [CCMenuItemFont itemFromString:@"PlayNextAnim" target:self selector:@selector(playAnim)];
//
//    CCMenuItemFont *stop =
//    [CCMenuItemFont itemFromString:@"Stop" target:self selector:@selector(stopAnimations)];
//
//    
//    resetRot.color = ccGREEN;
//    yawOnly.color = ccGREEN;
//    arcBall.color = ccGREEN;
//    playLooped.color = ccGREEN;
//    playOnce.color = ccGREEN;
//    play.color = ccGREEN;
//    stop.color = ccGREEN;
//    
//    CCMenu *menu = [CCMenu menuWithItems:
//                    resetRot,yawOnly,arcBall,
//                    playLooped, playOnce, play,stop, nil];
//
//    menu.position = ccp(800,480);
//    [menu alignItemsVerticallyWithPadding:10];
//    
//    [self addChild:menu];
////    CGRect r = [self boundingBoxInPixels];
// //   LogInfo(@"layer size %f %f %f %f",r.origin.x, r.origin.y, r.size.width, r.size.height);
//
//    
//    UIButton    *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,320,480)];
//    [btn setImage:[UIImage imageNamed:@"comingsoon"] forState:UIControlEventTouchUpInside];
//    [btn addTarget:self action:@selector(playAnim) forControlEvents:UIControlEventTouchUpInside];
//    [[[CCDirector sharedDirector] openGLView] addSubview:btn];
    
    
    [self addNavBar];
    
    
    [self addModel];
    [self addSkin];
    [self addHair];
    [self addTopClothese];
    [self addBottomClothese];
    [self addShoes];
    [self addGlasses];
    
    [self playAnim];
    
    [(AvatarSceneViewController*)[self cc3Scene] setAvatarSettings: _avatarSettings];
}


- (void) addNavBar
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,40)];
    imgView.image = [UIImage imageNamed:@"3dNavBg"];
    [[[CCDirector sharedDirector] openGLView] addSubview:imgView];
    [imgView release];
    imgView = nil;
    UIButton    *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(10,3,80,30);
    [btnBack setImage:[UIImage imageNamed:@"3dBackBtn"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector] openGLView] addSubview:btnBack];
    
    UIButton    *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStart.frame = CGRectMake(920,3,92,30);
    [btnStart setImage:[UIImage imageNamed:@"3dStartBtn"] forState:UIControlStateNormal];
    [btnStart addTarget:self action:@selector(playAnim) forControlEvents:UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector] openGLView] addSubview:btnStart];
    
}

- (void) onBack
{
    //[[NavigationBarManager sharedNavigationController] popViewControllerAnimated:YES];
}

- (void) addModel
{
    for (int i = 0; i < 6; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(200 + 109 * i + 20 * i,50,129,161);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"cha%d",i]] forState:UIControlStateNormal];
        [[[CCDirector sharedDirector] openGLView] addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnModelClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) btnModelClicked : (id)sender
{
    if([sender isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)sender;
        //self.avatarSettings.body = [[]
    }
}

- (void) addSkin
{
    //Add Skin Color
    
    UIImageView *skinTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,260,350,23)];
    skinTitleImg.image = [UIImage imageNamed:@"skinTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:skinTitleImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 290, 350,55)];
    
    for (int i = 0; i < Avatar_SkinItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60 * i ,0,45,45);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"skin%d",i+1]] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(btnScinTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
    }
    
    [scrollView setContentSize:CGSizeMake(60 * Avatar_SkinItemCount, 55)];
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = NO;
    
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
}

-(void) btnScinTouchUp:(id)sender
{
    if([sender isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton *)sender; 
        self.avatarSettings.skin = [[FileToSettingsConverter instance] getScinSettings:[NSString stringWithFormat: @"skin%d", btn.tag]];
    }
}

- (void) addHair
{
    //Add Hair Style
    
    UIImageView *hairTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,260,350,23)];
    hairTitleImg.image = [UIImage imageNamed:@"hairTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:hairTitleImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 290, 350,55)];
    
    for (int i = 0; i < Avatar_HairItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(90 * i ,0,45,35);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hairstyle%d",i+1]] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn];
    }
    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_HairScr;
    scrollView.delegate = self;
    
    [scrollView setContentSize:CGSizeMake(90 * Avatar_HairItemCount, 55)];
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    [scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,355,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_HairScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

- (void) addTopClothese
{
    //Add Top Clothese
    
    UIImageView *topClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,370,350,23)];
    topClotheImg.image = [UIImage imageNamed:@"clotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:topClotheImg];
    
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 400, 350,110)];
    
    for (int i = 0; i < Avatar_TopClothesItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(88 * i ,0,80,100);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shirt%d",i+1]] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn];
    }
    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_TopClotheScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(88 * Avatar_TopClothesItemCount, 110)];
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    [scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(290,520,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_TopClotheScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];

}

- (void) addBottomClothese
{
    //Add Bottom Clothese
    
    UIImageView *bottomClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,370,350,23)];
    bottomClotheImg.image = [UIImage imageNamed:@"bottomClotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:bottomClotheImg];
    
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 400, 350,110)];
    
    for (int i = 0; i < Avatar_BottomClothesItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(90 * i ,0,80,100);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"trousers%d",i+1]] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn];
    }
    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_BottomClotheScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(90 * Avatar_BottomClothesItemCount, 110)];
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    [scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,520,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_BottomClotheScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];


}

- (void) addShoes
{
    //Add Shoe Img
    
    UIImageView *shoeImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,540,350,23)];
    shoeImg.image = [UIImage imageNamed:@"shoeTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:shoeImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 570, 350,90)];
    
    for (int i = 0; i < Avatar_ShoesItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(90 * i ,0,75,80);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shoes%d",i+1]] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn];
    }
    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_ShoeScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(90 * Avatar_ShoesItemCount, 90)];
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    [scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(290,670,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_ShoeScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];

}

- (void) addGlasses
{
    //Add glassImg
    
    UIImageView *glassImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,540,350,23)];
    glassImg.image = [UIImage imageNamed:@"glassTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:glassImg];
    
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 570, 350,90)];
    
    for (int i = 0; i < Avatar_GlassItemCount; i ++)
    {
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120 * i ,0,92,58);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"glasses%d",i+1]] forState:UIControlStateNormal];
        
        [scrollView addSubview:btn];
    }
    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_GlassScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(120 * Avatar_GlassItemCount, 90)];
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    [scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,670,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_GlassScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];

}

/**
 * Override to perform tear-down activity prior to the scene disappearing.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) onCloseCC3Layer {}

/**
 * The ccTouchMoved:withEvent: method is optional for the <CCTouchDelegateProtocol>.
 * The event dispatcher will not dispatch events for which there is no method
 * implementation. Since the touch-move events are both voluminous and seldom used,
 * the implementation of ccTouchMoved:withEvent: has been left out of the default
 * CC3Layer implementation. To receive and handle touch-move events for object
 * picking, uncomment the following method implementation.
 */

-(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
	[super handleTouch: touch ofType: kCCTouchMoved];
}


#pragma mark - 
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float   scrOffset = scrollView.contentOffset.x;
    int pagingVal = scrOffset / Avatar_ScrollViewWidth;
    UIPageControl   *pgControl = (UIPageControl*)[[[CCDirector sharedDirector] openGLView] viewWithTag:(scrollView.tag + 1000)];
    
    pgControl.currentPage = pagingVal;
    
//    switch (scrollView.tag)
//    {
//        case Avatar_HairScr:
//        {
//
//            break;
//        }
//        case Avatar_TopClotheScr:
//        {
//            break;
//        }
//        case Avatar_BottomClotheScr:
//        {
//            break;
//        }
//        case Avatar_ShoeScr:
//        {
//            break;
//        }
//        case Avatar_GlassScr:
//        {
//            break;
//        }
//            
//        default:
//            break;
//    }
}


@end
