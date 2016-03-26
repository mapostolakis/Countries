//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataSource.h"
#import "MGADataSourceEvents.h"

@interface MGASingleSectionEventDataSource : NSObject <MGADataSource, MGADataSourceEvents>

- (instancetype)initWithEvent:(RACSignal *)signal;

- (void)start;

@end