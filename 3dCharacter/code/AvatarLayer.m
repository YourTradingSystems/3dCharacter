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
#import "UIButtonTag.h"

@interface CC3Layer(Private)

-(BOOL) handleTouch: (UITouch*) touch ofType: (uint) touchType;

@end

@implementation AvatarLayer
{
    BOOL _male;
    NSMutableArray *bodyButtons;
    NSMutableArray *skinButtons;
    NSMutableArray *hairButtons;
    NSMutableArray *topButtons;
    NSMutableArray *bottomButtons;
    NSMutableArray *shoesButtons;
    NSMutableArray *glassesButtons;
    
    UIScrollView *hairScrollView;
    UIScrollView *skinScrollView;
    UIScrollView *topClothesScrollView;
    UIScrollView *bottomClothesScrollView;
    UIScrollView *shoesScrollView;
    UIScrollView *glassesScrollView;
}

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
    _male = YES;
    _avatarSettings = [[AvatarModelSettings alloc] init];
    
    [self setContentSize:CGSizeMake(1024,768)];

    [self yawOnly];
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

-(void) yawOnly {
    [(AvatarSceneViewController*)[self cc3Scene] yawOnly];
}

-(void) onOpenCC3Layer {
    
    [self addNavBar];
    
    [self createBodyModelsView];
    [self createSkinView];
    [self createHairView];
    [self createTopClothesView];
    [self createBottomClothesView];
    [self createShoesView];
    [self createGlassesView];
    
    [(AvatarSceneViewController*)[self cc3Scene] setAvatarSettings: _avatarSettings];
    [[FileToSettingsConverter instance] setMale:YES];
    [self makeDefaultAvatar];
}

- (void) makeDefaultAvatar
{
    [self unsetButtons:shoesButtons];
    [self unsetButtons:skinButtons];
    [self unsetButtons:topButtons];
    [self unsetButtons:bottomButtons];
    [self unsetButtons:hairButtons];
    [self unsetButtons:bodyButtons];
    [self unsetButtons:glassesButtons];
    
    self.avatarSettings.shoes = (ModelSettings*) ((UIButtonTag*)[shoesButtons objectAtIndex:0]).tagSettings;
    ((UIButtonTag*)[shoesButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.skin = (ModelSettings*) ((UIButtonTag*)[skinButtons objectAtIndex:2]).tagSettings;
    ((UIButtonTag*)[skinButtons objectAtIndex:2]).selected = YES;
    self.avatarSettings.top = (ModelSettings*) ((UIButtonTag*)[topButtons objectAtIndex:3]).tagSettings;
    ((UIButtonTag*)[topButtons objectAtIndex:3]).selected = YES;
    self.avatarSettings.bottom = (ModelSettings*) ((UIButtonTag*)[bottomButtons objectAtIndex:0]).tagSettings;
    ((UIButtonTag*)[bottomButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.hair = (ModelSettings*) ((UIButtonTag*)[hairButtons objectAtIndex:0]).tagSettings;
    ((UIButtonTag*)[hairButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.body = (ModelSettings*) ((UIButtonTag*)[bodyButtons objectAtIndex:3]).tagSettings;
    ((UIButtonTag*)[bodyButtons objectAtIndex:3]).selected = YES;
    self.avatarSettings.glasses = (ModelSettings*) ((UIButtonTag*)[glassesButtons objectAtIndex:0]).tagSettings;
    ((UIButtonTag*)[glassesButtons objectAtIndex:0]).selected = YES;
}

- (void) addNavBar
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,1024,60)];
    imgView.image = [UIImage imageNamed:@"3dNavBg"];
    [[[CCDirector sharedDirector] openGLView] addSubview:imgView];
    [imgView release];
    imgView = nil;
    
    UIButton    *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(10,20,80,30);
    [btnBack setImage:[UIImage imageNamed:@"3dBackBtn"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector] openGLView] addSubview:btnBack];
    
    UIButton    *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStart.frame = CGRectMake(920,20,92,30);
    [btnStart setImage:[UIImage imageNamed:@"3dStartBtn"] forState:UIControlStateNormal];
    //[btnStart addTarget:self action:@selector(playAnim) forControlEvents:UIControlEventTouchUpInside];
    [btnStart addTarget:self action:@selector(makeDefaultAvatar) forControlEvents:UIControlEventTouchUpInside];
    [[[CCDirector sharedDirector] openGLView] addSubview:btnStart];
    
    [self addSliderMale];
}

-(void) addSliderMale
{
    UILabel *lblMaleFemale = [[UILabel alloc] init];
    lblMaleFemale.text = @"Male/Female";
    lblMaleFemale.frame = CGRectMake(750, 20, 100, 30);
    [[[CCDirector sharedDirector] openGLView] addSubview:lblMaleFemale];
    
    UISlider *sliderMale = [[UISlider alloc] init];
    sliderMale.frame = CGRectMake(860, 20, 50, 30);
    sliderMale.minimumValue = 0;
    sliderMale.maximumValue = 1;
    sliderMale.value = 0;
    [sliderMale addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [[[CCDirector sharedDirector] openGLView] addSubview:sliderMale];
}

-(void) sliderChanged : (id)sender
{
    UISlider *slider = (UISlider*) sender;
    float newStep = roundf(slider.value);
    slider.value = newStep;
    BOOL male = newStep <= 0.0f;
    [self setMale:male];
}

-(void) setMale: (BOOL) value
{
    if(_male != value)
    {
        _male = value;
        [[FileToSettingsConverter instance] setMale:_male];
        if(_male)
            [self prepareMaleAvatar];
        else
            [self prepareFemaleAvatar];
    }
}

-(void) prepareMaleAvatar
{
    [(AvatarSceneViewController*)[self cc3Scene] setMainNode:@"male_model.pod"];
    [self prepareButtons];
    [self makeDefaultAvatar];
}

-(void) prepareFemaleAvatar
{
    [(AvatarSceneViewController*)[self cc3Scene] setMainNode:@"female_model.pod"];
    [self prepareButtons];
    [self makeDefaultAvatar];
}

-(void) prepareButtons
{
    [self removeButtons:bodyButtons];
    [self addBodyButtons];
    
    [self removeButtons:hairButtons];
    [self addHairButtons];
    
    [self removeButtons:skinButtons];
    [self addSkinButtons];
    
    [self removeButtons:topButtons];
    [self addTopClothesButtons];
    
    [self removeButtons:bottomButtons];
    [self addBottomClothesButtons];
    
    [self removeButtons:shoesButtons];
    [self addShoesButtons];
    
    [self removeButtons:glassesButtons];
    [self addGlassesButtons];
}

-(void) removeButtons: (NSMutableArray*) buttons
{
    for (UIButtonTag *btnTag in buttons) {
        [btnTag removeFromSuperview];
    }
    [buttons removeAllObjects];
}

- (void) onBack
{
    //[[NavigationBarManager sharedNavigationController] popViewControllerAnimated:YES];
}

-(void) createBodyModelsView
{
    bodyButtons = [[NSMutableArray alloc] init];
    [self addBodyButtons];
}

-(void) addBodyButtons
{
    NSArray *sortedModelSets = [self getSortedTypeSettings:body];
    
    for (int i = 0; i < sortedModelSets.count; i++)
    {
        ModelSettings *set = sortedModelSets[i];
        UIButtonTag *btn = [self createButtonWithTag: set];
        btn.frame = CGRectMake(200 + 129 * (i+1), 50, 129, 161);
        [[[CCDirector sharedDirector] openGLView] addSubview:btn];
        [bodyButtons addObject:btn];
    }
}

-(NSArray*) getSortedTypeSettings: (enum modelType) type
{
    NSArray* modelSets = [[FileToSettingsConverter instance] getTypeSettings:type];
    NSArray *sortedArray;
    sortedArray = [modelSets sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        int first = ((ModelSettings*)a).index;
        int second = ((ModelSettings*)b).index;
        return first >= second;
    }];
    return sortedArray;
}

-(UIButtonTag*) createButtonWithTag: (ModelSettings*) modelSet
{
    UIButtonTag *btn = [UIButtonTag buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed: modelSet.screenName] forState:UIControlStateNormal];
    [btn setImage:[self imageWithShadowForImage:[UIImage imageNamed: modelSet.screenName]] forState: UIControlStateSelected];
    btn.tagSettings = modelSet;
    [btn addTarget:self action:@selector(buttonTouchedUp:) forControlEvents: UIControlEventTouchUpInside];
    return btn;
}

-(UIImage*)imageWithShadowForImage:(UIImage *)initialImage {
    
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, initialImage.size.width + 10, initialImage.size.height + 10, CGImageGetBitsPerComponent(initialImage.CGImage), 0, colourSpace, (enum CGBitmapInfo) kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(0,0), 15, [UIColor blueColor].CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(5, 5, initialImage.size.width, initialImage.size.height), initialImage.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

-(void) unsetButtons: (NSMutableArray*) buttons
{
    for (UIButtonTag *btnTag in buttons) {
        btnTag.selected = NO;
    }
}

-(void) buttonTouchedUp : (id)sender
{
    if([sender isKindOfClass:[UIButtonTag class]])
    {
        UIButtonTag *btn = (UIButtonTag *)sender;
        ModelSettings *settings = (ModelSettings*) btn.tagSettings;
        [self setAvatarSettings:settings];
        btn.selected = YES;
    }
}

-(void)setAvatarSettings:(ModelSettings *)settings
{
    switch (settings.type) {
        case skin:
            self.avatarSettings.skin = settings;
            [self unsetButtons:skinButtons];
            break;
        case body:
            self.avatarSettings.body = settings;
            [self unsetButtons:bodyButtons];
            break;
        case hair:
            self.avatarSettings.hair = settings;
            [self unsetButtons:hairButtons];
            break;
        case top:
            self.avatarSettings.top = settings;
            [self unsetButtons:topButtons];
            break;
        case bottom:
            self.avatarSettings.bottom = settings;
            [self unsetButtons:bottomButtons];
            break;
        case shoes:
            self.avatarSettings.shoes = settings;
            [self unsetButtons:shoesButtons];
            break;
        case glasses:
            self.avatarSettings.glasses = settings;
            [self unsetButtons:glassesButtons];
        default:
            break;
    }
}

- (void) createSkinView
{
    //Add Skin Color
    skinButtons = [[NSMutableArray alloc] init];

    UIImageView *skinTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,260,350,23)];
    skinTitleImg.image = [UIImage imageNamed:@"skinTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:skinTitleImg];
    
    skinScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 290, 350,55)];
    
    [self addSkinButtons];
    
    [skinScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    skinScrollView.showsHorizontalScrollIndicator = NO;
    skinScrollView.showsVerticalScrollIndicator = NO;
    skinScrollView.scrollEnabled = NO;
    
    [[[CCDirector sharedDirector] openGLView] addSubview:skinScrollView];
}

-(void) addSkinButtons
{
    NSArray* sortedSkinSets = [self getSortedTypeSettings:skin];
    
    for (int i = 0; i < sortedSkinSets.count; i ++)
    {
        ModelSettings *model = sortedSkinSets[i];
        UIButtonTag *btn = [self createButtonWithTag: model];
        btn.frame = CGRectMake(60 * i,0,45,45);
        [skinScrollView addSubview:btn];
        [skinButtons addObject:btn];
    }
    [skinScrollView setContentSize:CGSizeMake(60 * sortedSkinSets.count, 55)];
}

- (void) createHairView
{
    //Add Hair Style
    hairButtons = [[NSMutableArray alloc] init];
    
    UIImageView *hairTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,260,350,23)];
    hairTitleImg.image = [UIImage imageNamed:@"hairTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:hairTitleImg];
    
    hairScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 290, 350,55)];
    
    [hairScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    hairScrollView.pagingEnabled = YES;
    hairScrollView.showsHorizontalScrollIndicator = NO;
    hairScrollView.showsVerticalScrollIndicator = NO;
    hairScrollView.tag = Avatar_HairScr;
    hairScrollView.delegate = self;
    
    [self addHairButtons];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:hairScrollView];
    [hairScrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,355,350,20)];
    pageControl.numberOfPages = hairScrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_HairScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

-(void) addHairButtons
{
    NSArray* sortedHairSets = [self getSortedTypeSettings:hair];
    
    for (int i = 0; i < sortedHairSets.count; i ++)
    {
        ModelSettings* model = sortedHairSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: model];
        btn.frame = CGRectMake(90 * i ,0,45,35);
        [hairScrollView addSubview:btn];
        [hairButtons addObject:btn];
    }
    [hairScrollView setContentSize:CGSizeMake(90 * sortedHairSets.count, 55)];
}

- (void) createTopClothesView
{
    //Add Top Clothese
    topButtons = [[NSMutableArray alloc] init];
    
    UIImageView *topClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,370,350,23)];
    topClotheImg.image = [UIImage imageNamed:@"clotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:topClotheImg];
    
    topClothesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 400, 350,110)];
    
    [topClothesScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    topClothesScrollView.pagingEnabled = YES;
    topClothesScrollView.showsHorizontalScrollIndicator = NO;
    topClothesScrollView.showsVerticalScrollIndicator = NO;
    topClothesScrollView.tag = Avatar_TopClotheScr;
    topClothesScrollView.delegate = self;

    [self addTopClothesButtons];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:topClothesScrollView];
    [topClothesScrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(290,520,350,20)];
    pageControl.numberOfPages = topClothesScrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_TopClotheScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

-(void) addTopClothesButtons
{
    NSArray* sortedTopSets = [self getSortedTypeSettings: top];
    
    for (int i = 0; i < sortedTopSets.count; i ++)
    {
        ModelSettings *model = sortedTopSets[i];
        UIButtonTag *btn = [self createButtonWithTag: model];
        btn.frame = CGRectMake(88 * i, 0, 80, 100);
        [topClothesScrollView addSubview:btn];
        [topButtons addObject:btn];
    }
    
    [topClothesScrollView setContentSize:CGSizeMake(88 * sortedTopSets.count, 110)];
}

- (void) createBottomClothesView
{
    //Add Bottom Clothese
    bottomButtons = [[NSMutableArray alloc] init];
    
    UIImageView *bottomClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,370,350,23)];
    bottomClotheImg.image = [UIImage imageNamed:@"bottomClotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:bottomClotheImg];
    
    bottomClothesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 400, 350,110)];
    
    [bottomClothesScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    bottomClothesScrollView.pagingEnabled = YES;
    bottomClothesScrollView.showsHorizontalScrollIndicator = NO;
    bottomClothesScrollView.showsVerticalScrollIndicator = NO;
    bottomClothesScrollView.tag = Avatar_BottomClotheScr;
    bottomClothesScrollView.delegate = self;
    
    [self addBottomClothesButtons];

    [[[CCDirector sharedDirector] openGLView] addSubview:bottomClothesScrollView];
    [bottomClothesScrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,520,350,20)];
    pageControl.numberOfPages = bottomClothesScrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_BottomClotheScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

-(void) addBottomClothesButtons
{
    NSArray* sortedBottomSets = [self getSortedTypeSettings:bottom];
    
    for (int i = 0; i < sortedBottomSets.count; i ++)
    {
        ModelSettings* model = sortedBottomSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: model];
        btn.frame = CGRectMake(90 * i ,0,80,100);
        [bottomClothesScrollView addSubview:btn];
        [bottomButtons addObject:btn];
    }
    [bottomClothesScrollView setContentSize:CGSizeMake(90 * sortedBottomSets.count, 110)];
}

- (void) createShoesView
{
    //Add Shoe Img
    shoesButtons = [[NSMutableArray alloc] init];
    
    UIImageView *shoeImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,540,350,23)];
    shoeImg.image = [UIImage imageNamed:@"shoeTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:shoeImg];
    
    shoesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 570, 350,90)];
    
    [shoesScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    shoesScrollView.pagingEnabled = YES;
    shoesScrollView.showsHorizontalScrollIndicator = NO;
    shoesScrollView.showsVerticalScrollIndicator = NO;
    shoesScrollView.tag = Avatar_ShoeScr;
    shoesScrollView.delegate = self;
    
    [self addShoesButtons];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:shoesScrollView];
    [shoesScrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(290,670,350,20)];
    pageControl.numberOfPages = shoesScrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_ShoeScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

-(void) addShoesButtons
{
    NSArray* sortedShoesSets = [self getSortedTypeSettings:shoes];
    
    for (int i = 0; i < sortedShoesSets.count; i++)
    {
        ModelSettings* set = sortedShoesSets[i];
        UIButtonTag *btn = [self createButtonWithTag:set];
        btn.frame = CGRectMake(90 * i ,0,75,80);
        [shoesScrollView addSubview:btn];
        [shoesButtons addObject: btn];
    }
    [shoesScrollView setContentSize:CGSizeMake(90 * sortedShoesSets.count, 90)];
}

- (void) createGlassesView
{
    //Add glassImg
    glassesButtons =[[NSMutableArray alloc] init];
    
    UIImageView *glassImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,540,350,23)];
    glassImg.image = [UIImage imageNamed:@"glassTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:glassImg];
    
    glassesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 570, 350,90)];
    
    [glassesScrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    glassesScrollView.pagingEnabled = YES;
    glassesScrollView.showsHorizontalScrollIndicator = NO;
    glassesScrollView.showsVerticalScrollIndicator = NO;
    glassesScrollView.tag = Avatar_GlassScr;
    glassesScrollView.delegate = self;
    
    [self addGlassesButtons];

    [[[CCDirector sharedDirector] openGLView] addSubview:glassesScrollView];
    [glassesScrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(655,670,350,20)];
    pageControl.numberOfPages = glassesScrollView.contentSize.width / Avatar_ScrollViewWidth;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.tag = Avatar_GlassScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    [pageControl release];
}

-(void) addGlassesButtons
{
    NSArray* sortedGlassesSets = [self getSortedTypeSettings:glasses];
    
    for (int i = 0; i < sortedGlassesSets.count; i ++)
    {
        ModelSettings* modelSet = sortedGlassesSets[i];
        UIButtonTag *btn = [self createButtonWithTag: modelSet];
        btn.frame = CGRectMake(120 * i ,0,92,58);
        [glassesScrollView addSubview:btn];
        [glassesButtons addObject:btn];
    }
    
    [glassesScrollView setContentSize:CGSizeMake(120 * sortedGlassesSets.count, 90)];
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
}


@end
