//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataSource.h"

@class RACSignal;

@interface MGASingleSectionEventDataSource : NSObject <MGADataSource>

- (instancetype)initWithSignal:(RACSignal *)signal;

- (void)start;

@end