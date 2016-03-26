//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACCommand;

@interface UINavigationItem (MGARefresh)

- (void)addRefreshItemWithCommand:(RACCommand *)command;

@end