//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAViewControllerPresenter.h"

@interface MGANavigationControllerPushPresenter : NSObject <MGAViewControllerPresenter>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end