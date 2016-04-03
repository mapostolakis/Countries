//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerPushPresenter.h"

@interface MGANavigationControllerPushPresenter ()

@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation MGANavigationControllerPushPresenter

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
    [self.navigationController pushViewController:viewController animated:YES];
}

@end