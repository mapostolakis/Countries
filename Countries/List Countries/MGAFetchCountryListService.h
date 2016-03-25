//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol MGAFetchCountryListService <NSObject>

- (RACSignal *)fetchCountries;

@end