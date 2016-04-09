//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsFlowFactory.h"
#import "MGAListCountriesFlowFactory.h"
@import UIKit;

@class MGAInMemoryStore;
@protocol MGADataSourceProvider, MGAServiceProvider;

@interface MGAFlowFactory : NSObject <MGACountryDetailsFlowFactory, MGAListCountriesFlowFactory>

- (instancetype)initWithInMemoryStore:(MGAInMemoryStore *)store
                 navigationController:(UINavigationController *)navigationController
                   dataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
                      serviceProvider:(id <MGAServiceProvider>)serviceProvider;

@end