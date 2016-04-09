//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGANavigationControllerLastItemReplacingPresenter.h"

@interface MGANavigationControllerLastItemReplacingPresenter ()

@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation MGANavigationControllerLastItemReplacingPresenter

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
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeLastObject];
    [viewControllers addObject:viewController];
    [self.navigationController setViewControllers:[viewControllers copy] animated:YES];
}

@end