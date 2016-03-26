//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionTableViewReloadBinder.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGACommandExecutionTableViewReloadBinder ()

@property (nonatomic, readonly) RACCommand *command;
@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation MGACommandExecutionTableViewReloadBinder

- (instancetype)initWithCommand:(RACCommand *)command tableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        _command = command;
        _tableView = tableView;
    }
    return self;
}

- (void)bind
{
    UITableView *tableView = self.tableView;
    [[[self.command executionSignals] switchToLatest] subscribeNext:^(id x) {
        [tableView reloadData];
    }];
}

@end