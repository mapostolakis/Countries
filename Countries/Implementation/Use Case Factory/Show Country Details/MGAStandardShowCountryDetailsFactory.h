//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAShowCountryDetailsFactory.h"

@protocol MGAFlagURLProvider, MGACountryGateway;

@interface MGAStandardShowCountryDetailsFactory : NSObject <MGAShowCountryDetailsFactory>

- (instancetype)initWithFlagURLProvider:(id <MGAFlagURLProvider>)flagURLProvider gateway:(id <MGACountryGateway>)gateway;

@end