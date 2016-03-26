//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGAFetchCountryListService;

@protocol MGAFetchCountryListServiceProvider <NSObject>

- (id <MGAFetchCountryListService>)createFetchCountryListService;

@end