//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand, MGASingleSectionDataSource;

@interface MGACommandExecutionSingleSectionDataSourceBinder : NSObject

- (instancetype)initWithCommand:(RACCommand *)command dataSource:(MGASingleSectionDataSource *)dataSource;

- (void)bind;

@end