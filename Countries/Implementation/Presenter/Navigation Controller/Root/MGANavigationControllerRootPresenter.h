//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAViewControllerPresenter.h"

@interface MGANavigationControllerRootPresenter : NSObject <MGAViewControllerPresenter>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end