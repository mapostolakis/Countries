//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardDataSourceProvider.h"
#import "MGASingleSectionEventDataSource.h"

@implementation MGAStandardDataSourceProvider

- (id <MGADataSource>)createCountryListDataSourceForEvent:(RACSignal *)signal
{
    MGASingleSectionEventDataSource *dataSource = [[MGASingleSectionEventDataSource alloc] initWithSignal:signal];
    [dataSource start];
    return dataSource;
}

@end