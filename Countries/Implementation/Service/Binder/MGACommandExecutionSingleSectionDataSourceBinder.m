//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionSingleSectionDataSourceBinder.h"
#import "MGASingleSectionDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGACommandExecutionSingleSectionDataSourceBinder ()

@property (nonatomic, readonly) RACCommand *command;
@property (nonatomic, readonly) MGASingleSectionDataSource *dataSource;

@end

@implementation MGACommandExecutionSingleSectionDataSourceBinder

- (instancetype)initWithCommand:(RACCommand *)command dataSource:(MGASingleSectionDataSource *)dataSource
{
    self = [super init];
    if (self) {
        _command = command;
        _dataSource = dataSource;
    }
    return self;
}

- (void)bind
{
    [[self.command.executionSignals switchToLatest] subscribeNext:^(NSArray *response) {
        self.dataSource.items = [response copy];
    }];
}

@end