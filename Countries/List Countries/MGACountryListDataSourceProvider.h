//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@protocol MGADataSource;

@protocol MGACountryListDataSourceProvider <NSObject>

- (id <MGADataSource>)createCountryListDataSourceForEvent:(RACSignal *)signal;

@end