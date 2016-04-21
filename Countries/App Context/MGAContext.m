//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAContext.h"
#import "MGADataSourceProvider.h"
#import "MGAServiceProvider.h"
#import "MGAListCountriesFlow.h"
#import "MGAStandardDataSourceProvider.h"
#import "MGAStandardServiceProvider.h"
#import "MGAInMemoryStore.h"
#import "MGAFlowFactory.h"

@interface MGAContext ()

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, strong) id <MGAServiceProvider> serviceProvider;
@property (nonatomic, strong) id <MGAStore> store;
@property (nonatomic, strong) MGAFlowFactory *flowFactory;

@end

@implementation MGAContext

- (void)start
{
    [[self.flowFactory createCountryListFlow] start];
    [[self.flowFactory createMappedCountryListFlow] start];
}

- (UIViewController *)rootViewController
{
    return self.tabBarController;
}

- (UITabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    return _tabBarController;
}

- (id <MGADataSourceProvider>)dataSourceProvider
{
    if (_dataSourceProvider == nil) {
        _dataSourceProvider = [[MGAStandardDataSourceProvider alloc] init];
    }
    return _dataSourceProvider;
}

- (id <MGAServiceProvider>)serviceProvider
{
    if (_serviceProvider == nil) {
        _serviceProvider = [[MGAStandardServiceProvider alloc] initWithStore:self.store];
    }
    return _serviceProvider;
}

- (id <MGAStore>)store
{
    if (_store == nil) {
        _store = [[MGAInMemoryStore alloc] init];
    }
    return _store;
}

- (MGAFlowFactory *)flowFactory
{
    if (_flowFactory == nil) {
        _flowFactory = [[MGAFlowFactory alloc] initWithInMemoryStore:self.store
                                                    tabBarController:self.tabBarController
                                                  dataSourceProvider:self.dataSourceProvider
                                                     serviceProvider:self.serviceProvider];
    }
    return _flowFactory;
}

@end