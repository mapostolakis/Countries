//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFactory.h"

@class RACCommand;

@interface MGAMappedCountryListFactory : NSObject <MGAListCountriesFactory>

- (instancetype)initWithServiceCommand:(RACCommand *)command;

@end