//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFactory.h"

@protocol MGAFlagURLProvider, MGACountryGateway;

@interface MGAStandardCountryDetailsFactory : NSObject <MGACountryDetailsFactory>

- (instancetype)initWithFlagURLProvider:(id <MGAFlagURLProvider>)flagURLProvider gateway:(id <MGACountryGateway>)gateway;

@end