//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UITabBarController+MGAAdditions.h"

@implementation UITabBarController (MGAAdditions)

- (void)mga_addViewController:(UIViewController *)viewController
{
    if (self.viewControllers == nil) { self.viewControllers = @[viewController]; }
    NSMutableArray *array = [self.viewControllers mutableCopy];
    [array addObject:viewController];
    self.viewControllers = [array copy];
}

@end