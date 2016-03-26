//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UINavigationItem+MGARefresh.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UINavigationItem (MGARefresh)

- (void)addRefreshItemWithCommand:(RACCommand *)command
{
    UIBarButtonItem *spinnerItem = [self createSpinnerItemWithCommand:command];
    UIBarButtonItem *refreshItem = [self createRefreshItemWithCommand:command];
    RAC(self, rightBarButtonItem) = [[command executing] map:^id(NSNumber *isExecuting) {
        return isExecuting.boolValue ? spinnerItem : refreshItem;
    }];
}

- (UIBarButtonItem *)createSpinnerItemWithCommand:(RACCommand *)command
{
    UIActivityIndicatorView *spinner =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    item.rac_command = command;
    return item;
}

- (UIBarButtonItem *)createRefreshItemWithCommand:(RACCommand *)command
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                          target:nil
                                                                          action:nil];
    item.rac_command = command;
    return item;
}

@end