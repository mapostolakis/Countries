//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerRootPresenter.h"

@interface MGANavigationControllerRootPresenter ()

@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation MGANavigationControllerRootPresenter

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    return self;
}

- (void)present:(UIViewController *)viewController
{
    [self.navigationController setViewControllers:@[viewController] animated:NO];
}

@end