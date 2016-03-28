//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardDataSourceProvider.h"
#import "MGASingleSectionDataSource.h"

@implementation MGAStandardDataSourceProvider

- (id <MGADataSource>)createCountryListDataSource
{
    return [[MGASingleSectionDataSource alloc] init];
}

@end