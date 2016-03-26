//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFactory.h"

@protocol MGAServiceProvider, MGADataSourceProvider;

@interface MGAStandardListCountriesFactory : NSObject <MGAListCountriesFactory>

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                           serviceProvider:(id <MGAServiceProvider>)serviceProvider;
@end