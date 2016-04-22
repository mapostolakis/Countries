//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListCountriesFactory.h"

@class RACCommand;
@protocol MGADataSourceProvider;

@interface MGAStandardListCountriesFactory : NSObject <MGAListCountriesFactory>

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                            serviceCommand:(RACCommand *)command;
@end