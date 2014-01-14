//
//  ButtonsScrollController.m
//  3DCharacter.temp_caseinsensitive_rename
//
//  Created by Vasya on 1/14/14.
//  Copyright (c) 2014 1. All rights reserved.
//

#import "ButtonsScrollController.h"
#import "CC3Layer.h"
#import "UIButtonTag.h"
#import "FileToSettingsConverter.h"

@implementation ButtonsScrollController
{
    NSMutableArray *tagButtons;
    UIScrollView *scrollView;
}

- (void) createShoesView
{
    //Add Shoe Img
    tagButtons = [[NSMutableArray alloc] init];
    
    UIImageView *shoeImg = [[UIImageView alloc] initWithFrame:CGRectMake(290,540,350,23)];
    shoeImg.image = [UIImage imageNamed:@"shoeTitle"];
    [[[CCDirector sharedDirector] openGLView] addSubview:shoeImg];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(290, 570, 350,90)];
    
    [scrollView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    //scrollView.tag = Avatar_ShoeScr;
    //scrollView.delegate = self;
    
    [self addShoesButtons];
    
    [[[CCDirector sharedDirector] openGLView] addSubview:scrollView];
    //[scrollView release];
    
    UIPageControl   *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(290,670,350,20)];
    pageControl.numberOfPages = scrollView.contentSize.width / 350;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //pageControl.tag = Avatar_ShoeScr + 1000;
    [[[CCDirector sharedDirector] openGLView] addSubview:pageControl];
    //[pageControl release];
}

-(void) addShoesButtons
{
    NSArray* sortedShoesSets = [self getSortedTypeSettings:shoes];
    
    for (int i = 0; i < sortedShoesSets.count; i++)
    {
        ModelSettings* set = sortedShoesSets[i];
        UIButtonTag *btn = [self createButtonWithTag:set];
        btn.frame = CGRectMake(90 * i ,0,75,80);
        [scrollView addSubview:btn];
        [tagButtons addObject: btn];
    }
    [scrollView setContentSize:CGSizeMake(90 * sortedShoesSets.count, 90)];
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

-(void) buttonTouchedUp : (id)sender
{
    if([sender isKindOfClass:[UIButtonTag class]])
    {
        for (UIButtonTag *btnTag in tagButtons) {
            btnTag.selected = NO;
        }
        UIButtonTag *btn = (UIButtonTag *)sender;
        ModelSettings *settings = (ModelSettings*) btn.tagSettings;
        [self setAvatarSettings:settings];
        btn.selected = YES;
    }
}

-(void)setAvatarSettings:(ModelSettings *)settings
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:settings forKey:@"shoes"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"settingChanged" object:nil userInfo:userInfo];
}

-(void) updateButtons
{
    [self removeButtons:tagButtons];
    [self addShoesButtons];
}

-(void) removeButtons: (NSMutableArray*) buttons
{
    for (UIButtonTag *btnTag in buttons) {
        [btnTag removeFromSuperview];
    }
    [buttons removeAllObjects];
}

-(void) setSelectedItemAtIndex: (int) index;
{
    for (UIButtonTag *btnTag in tagButtons) {
        btnTag.selected = NO;
    }
    UIButtonTag *btnSel = (UIButtonTag*)[tagButtons objectAtIndex:index];
    btnSel.selected = YES;
    [self setAvatarSettings: (ModelSettings*) btnSel.tagSettings];
}

@end
