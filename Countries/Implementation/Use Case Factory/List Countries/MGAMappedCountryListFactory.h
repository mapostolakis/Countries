//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFactory.h"

@protocol MGAAnnotationProvider;

@interface MGAMappedCountryListFactory : NSObject <MGAListCountriesFactory>

- (instancetype)initWithAnnotationProvider:(id <MGAAnnotationProvider>)builder;

@end