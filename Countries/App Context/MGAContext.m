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
#import "MGAInMemoryStoreGateway.h"
#import "MGAFlowFactory.h"

@interface MGAContext ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) id <MGADataSourceProvider> dataSourceProvider;
@property (nonatomic, strong) id <MGAServiceProvider> serviceProvider;
@property (nonatomic, strong) id <MGAStore> store;
@property (nonatomic, strong) id <MGACountryGateway> inMemoryCountryGateway;
@property (nonatomic, strong) MGAFlowFactory *flowFactory;

@end

@implementation MGAContext

- (void)start
{
    [[self.flowFactory createCountryListFlow] start];
}

- (UIViewController *)rootViewController
{
    return self.navigationController;
}

- (UINavigationController *)navigationController
{
    if (_navigationController == nil) {
        _navigationController = [[UINavigationController alloc] init];
    }
    return _navigationController;
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

- (id <MGACountryGateway>)inMemoryCountryGateway
{
    if (_inMemoryCountryGateway == nil) {
        _inMemoryCountryGateway = [[MGAInMemoryStoreGateway alloc] initWithStore:self.store];
    }
    return _inMemoryCountryGateway;
}

- (MGAFlowFactory *)flowFactory
{
    if (_flowFactory == nil) {
        _flowFactory = [[MGAFlowFactory alloc] initWithInMemoryStore:self.store
                                                navigationController:self.navigationController
                                                  dataSourceProvider:self.dataSourceProvider
                                                     serviceProvider:self.serviceProvider];
    }
    return _flowFactory;
}

@end