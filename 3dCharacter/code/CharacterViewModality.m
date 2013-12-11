//
//  CharacterViewModality.m
//  OBI
//
//  Created by Wu on 7/12/13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//

#import "CharacterViewModality.h"
//#import "AppContainer.h"
//#import "ModalityControllerProtocol.h"

@implementation CharacterViewModality
- (NSString*)name {
    return @"Test Create Your Avatar";
}

- (NSString*)typeIdentifier {
    return @"3DCharacterMaker";
}

- (Class)controllerClass {
    return NSClassFromString(@"CharacterViewController");
}

- (void)showModalityControllerWithActivity:(ActivityItem*)activity {
    if(self.controllerClass) {
        UIViewController * viewController = [[self.controllerClass alloc] init];
        if([viewController conformsToProtocol:@protocol(ModalityControllerProtocol)]) {
            ((id<ModalityControllerProtocol>)viewController).activity = activity;
        }
        //[[NavigationBarManager sharedNavigationController] pushViewController:viewController animated:YES];
    }
}


@end
