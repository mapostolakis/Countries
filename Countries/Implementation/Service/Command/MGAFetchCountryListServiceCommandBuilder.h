//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@protocol MGAFetchCountryListService;

@interface MGAFetchCountryListServiceCommandBuilder : NSObject

- (instancetype)initWithService:(id <MGAFetchCountryListService>)service;

- (RACCommand *)build;

@end