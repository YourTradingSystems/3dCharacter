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
    NSMutableArray *modelButtons;
    NSMutableArray *skinButtons;
    NSMutableArray *hairButtons;
    NSMutableArray *topButtons;
    NSMutableArray *bottomButtons;
    NSMutableArray *shoesButtons;
    NSMutableArray *glassesButtons;
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
    _male = NO;
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

-(void) yawOnly {
    [(AvatarSceneViewController*)[self cc3Scene] yawOnly];
}

-(void) playAnim {
    id aClass = self.cc3Scene;
    NSLog(@"cc3Scene.class = %@", [aClass class]);
    
    if (![aClass respondsToSelector:@selector(playAnim)]) {
        NSLog(@"%@ not contain selector playAnim", [aClass class]);
    }
    
    [(AvatarSceneViewController*)[self cc3Scene] playAnim];
}

-(void) playAnimModeOnce {
    [(AvatarSceneViewController*)[self cc3Scene] playAnimModeOnce];
}


-(void) onOpenCC3Layer {
    
    [self addNavBar];
    
    [self createModelButtons];
    [self addSkin];
    [self addHair];
    [self addTopClothese];
    [self addBottomClothese];
    [self addShoes];
    [self addGlasses];
    
    [self playAnim];
    
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
    [self unsetButtons:modelButtons];
    [self unsetButtons:glassesButtons];
    
    self.avatarSettings.shoes = (ModelSettings*) [[FileToSettingsConverter instance] getSettings: @"shoes1"];
    ((UIButtonTag*)[shoesButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.skin = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: @"skin3"];
    ((UIButtonTag*)[skinButtons objectAtIndex:2]).selected = YES;
    self.avatarSettings.top = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: @"shirt5"];
    ((UIButtonTag*)[topButtons objectAtIndex:3]).selected = YES;
    self.avatarSettings.bottom = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: @"trousers1"];
    ((UIButtonTag*)[bottomButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.hair = (ModelSettings*) [[FileToSettingsConverter instance] getSettings: @"hairstyle1"];
    ((UIButtonTag*)[hairButtons objectAtIndex:0]).selected = YES;
    self.avatarSettings.body = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: @"cha3"];
    ((UIButtonTag*)[modelButtons objectAtIndex:3]).selected = YES;
    self.avatarSettings.glasses = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: @"glasses1"];
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
    [btnStart addTarget:self action:@selector(playAnim) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self makeDefaultAvatar];
}

-(void) prepareFemaleAvatar
{
    [(AvatarSceneViewController*)[self cc3Scene] setMainNode:@"female_model.pod"];
    [self makeDefaultAvatar];
}

- (void) onBack
{
    //[[NavigationBarManager sharedNavigationController] popViewControllerAnimated:YES];
}

-(void) createModelButtons
{
    modelButtons = [[NSMutableArray alloc] init];
    
    NSArray *sortedModelSets = [self getSortedTypeSettings:body];
    
    for (int i = 0; i < sortedModelSets.count; i++)
    {
        ModelSettings* set = sortedModelSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: set.screenName];
        btn.frame = CGRectMake(200 + 129 * (i+1), 50, 129, 161);
        [[[CCDirector sharedDirector] openGLView] addSubview:btn];
        [modelButtons addObject:btn];
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

-(UIButtonTag*) createButtonWithTag: (NSString*) name
{
    UIButtonTag *btn = [UIButtonTag buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed: name] forState:UIControlStateNormal];
    [btn setImage:[self imageWithShadowForImage:[UIImage imageNamed: name]] forState: UIControlStateSelected];
    btn.tagSettings = [[FileToSettingsConverter instance] getSettings: name];
    btn.tagName = name;
    [btn addTarget:self action:@selector(buttonTouchedUp:) forControlEvents: UIControlEventTouchUpInside];
    return btn;
}

-(UIImage*)imageWithShadowForImage:(UIImage *)initialImage {
    
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, initialImage.size.width + 10, initialImage.size.height + 10, CGImageGetBitsPerComponent(initialImage.CGImage), 0, colourSpace, kCGImageAlphaPremultipliedLast);
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
        ModelSettings *settings = (ModelSettings*)[[FileToSettingsConverter instance] getSettings: btn.tagName];
        switch (settings.type) {
            case skin:
                self.avatarSettings.skin = settings;
                [self unsetButtons:skinButtons];
                break;
            case body:
                self.avatarSettings.body = settings;
                [self unsetButtons:modelButtons];
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
                //TODO glasses model problem
                self.avatarSettings.glasses = settings;
                [self unsetButtons:glassesButtons];
            default:
                break;
            }
        btn.selected = YES;
    }
}

- (void) addSkin
{
    //Add Skin Color
    skinButtons = [[NSMutableArray alloc] init];

    UIImageView *skinTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,260,350,23)];
    skinTitleImg.image = [UIImage imageNamed:@"skinTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:skinTitleImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 290, 350,55)];
    NSArray* sortedSkinSets = [self getSortedTypeSettings:skin];
    
    for (int i = 0; i < sortedSkinSets.count; i ++)
    {
        ModelSettings *model = sortedSkinSets[i];
        UIButtonTag *btn = [self createButtonWithTag: model.screenName];
        btn.frame = CGRectMake(60 * i,0,45,45);
        [scrollView addSubview:btn];
        [skinButtons addObject:btn];
    }
    
    [scrollView setContentSize:CGSizeMake(60 * sortedSkinSets.count, 55)];
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = NO;
    
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
}

- (void) addHair
{
    //Add Hair Style
    hairButtons = [[NSMutableArray alloc] init];
    
    UIImageView *hairTitleImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,260,350,23)];
    hairTitleImg.image = [UIImage imageNamed:@"hairTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:hairTitleImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 290, 350,55)];
    NSArray* sortedHairSets = [self getSortedTypeSettings:hair];
    
    for (int i = 0; i < sortedHairSets.count; i ++)
    {
        ModelSettings* model = sortedHairSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: model.screenName];
        btn.frame = CGRectMake(90 * i ,0,45,35);
        [scrollView addSubview:btn];
        [hairButtons addObject:btn];
    }    
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_HairScr;
    scrollView.delegate = self;
    
    [scrollView setContentSize:CGSizeMake(90 * sortedHairSets.count, 55)];
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
    topButtons = [[NSMutableArray alloc] init];
    
    UIImageView *topClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,370,350,23)];
    topClotheImg.image = [UIImage imageNamed:@"clotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:topClotheImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 400, 350,110)];
    NSArray* sortedTopSets = [self getSortedTypeSettings: top];
    
    for (int i = 0; i < sortedTopSets.count; i ++)
    {
        ModelSettings* model = sortedTopSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: model.screenName];
        btn.frame = CGRectMake(88 * i ,0,80,100);
        [scrollView addSubview:btn];
        [topButtons addObject:btn];
    }
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_TopClotheScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(88 * sortedTopSets.count, 110)];
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
    bottomButtons = [[NSMutableArray alloc] init];
    
    UIImageView *bottomClotheImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,370,350,23)];
    bottomClotheImg.image = [UIImage imageNamed:@"bottomClotheTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:bottomClotheImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 400, 350,110)];
    NSArray* sortedBottomSets = [self getSortedTypeSettings:bottom];
    
    for (int i = 0; i < sortedBottomSets.count; i ++)
    {
        ModelSettings* model = sortedBottomSets[i];
        UIButtonTag    *btn = [self createButtonWithTag: model.screenName];
        btn.frame = CGRectMake(90 * i ,0,80,100);
        [scrollView addSubview:btn];
        [bottomButtons addObject:btn];
    }
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_BottomClotheScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(90 * sortedBottomSets.count, 110)];
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
    shoesButtons = [[NSMutableArray alloc] init];
    
    UIImageView *shoeImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,540,350,23)];
    shoeImg.image = [UIImage imageNamed:@"shoeTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:shoeImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 570, 350,90)];
    
    NSArray* sortedShoesSets = [self getSortedTypeSettings:shoes];
    
    for (int i = 0; i < sortedShoesSets.count; i++)
    {
        ModelSettings* set = sortedShoesSets[i];
        UIButtonTag *btn = [self createButtonWithTag:set.screenName];
        btn.frame = CGRectMake(90 * i ,0,75,80);
        [scrollView addSubview:btn];
        [shoesButtons addObject: btn];
    }
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_ShoeScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(90 * sortedShoesSets.count, 90)];
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
    glassesButtons =[[NSMutableArray alloc] init];
    
    UIImageView *glassImg = [[UIImageView alloc] initWithFrame:CGRectMake(655,540,350,23)];
    glassImg.image = [UIImage imageNamed:@"glassTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:glassImg];
    
    UIScrollView    *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(655, 570, 350,90)];
    
    NSArray* sortedGlassesSets = [self getSortedTypeSettings:glasses];
    
    for (int i = 0; i < sortedGlassesSets.count; i ++)
    {
        ModelSettings* modelSet = sortedGlassesSets[i];
        UIButtonTag *btn = [self createButtonWithTag: modelSet.screenName];
        btn.frame = CGRectMake(120 * i ,0,92,58);
        [scrollView addSubview:btn];
        [glassesButtons addObject:btn];
    }
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.tag = Avatar_GlassScr;
    scrollView.delegate = self;

    [scrollView setContentSize:CGSizeMake(120 * sortedGlassesSets.count, 90)];
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
}


@end
