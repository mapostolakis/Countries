//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAShowCountryDetailsFactory.h"

@protocol MGAFlagURLProvider;

@interface MGAStandardShowCountryDetailsFactory : NSObject <MGAShowCountryDetailsFactory>

- (instancetype)initWithFlagURLProvider:(id <MGAFlagURLProvider>)flagURLProvider;

@end