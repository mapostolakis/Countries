//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGAViewControllerPresenter <NSObject>

- (void)present:(UIViewController *)viewController;

@end